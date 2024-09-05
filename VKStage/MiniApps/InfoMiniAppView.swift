//
//  InfoMiniAppView.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import UIKit
import SnapKit
import CoreGraphics

//класс для мини приложений с погодой и городом, ибо суть у них одинаковая, просто немного разная
class InfoMiniAppView: MiniApp{
    
    internal var infoLabel = UILabel()
    internal var dataLabel = UILabel()
    internal var updateButton = UIButton()
    internal var updateButtonHandler: (() -> ())?
    
    internal weak var viewController: UIViewController? {
        var responder: UIResponder? = self
        while responder?.next != nil{
            if let controller = responder as? UIViewController { return controller }
            responder = responder?.next
        }
        return nil
    }

    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    override func setup(){
        super.setup()
        //Лейбл текщая температура
        self.addSubview(infoLabel)
        infoLabel.font = UIFont.systemFont(ofSize: 36)
        infoLabel.textColor = .systemBackground
        infoLabel.numberOfLines = 2
        infoLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(30)
            maker.centerX.equalToSuperview()
        }
        
        //Лейбл с градусами
        self.addSubview(dataLabel)
        dataLabel.font = UIFont.systemFont(ofSize: 76)
        dataLabel.textColor = .systemBackground
        dataLabel.numberOfLines = 2
        dataLabel.snp.makeConstraints { maker in
            maker.top.equalTo(infoLabel.snp.bottom).offset(50)
            maker.centerX.equalTo(infoLabel)
        }
        
        //Кнопка обновления
        self.addSubview(updateButton)
        let symbconf = UIImage.SymbolConfiguration(pointSize: 36, weight: .semibold)
        let image = UIImage(systemName: "arrow.triangle.2.circlepath")?.withConfiguration(symbconf)
        updateButton.setImage(image, for: .normal)
        updateButton.tintColor = .systemBackground
        updateButton.addAction(UIAction(handler: {[unowned self] _ in
            if let updateButtonHandler = self.updateButtonHandler { updateButtonHandler()
                UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
                    updateButton.transform = updateButton.transform.rotated(by: .pi)
                })
            }
        }), for: .touchUpInside)
        updateButton.snp.makeConstraints { maker in
            maker.trailing.bottom.equalToSuperview()
            maker.width.height.equalTo(68)
        }
    }
    
    //MARK: - MiniApp Protocol
    
    override func setMinSize(animated: Bool = true) {
        super.setMinSize(animated: animated)
    }
    
    override func setHalfSize(animated: Bool = true) {
        super.setHalfSize(animated: animated)
    }
    
    override func setFullSize(animated: Bool = true) {
        super.setFullSize(animated: animated)
    }
    
    //MARK: - Показываем и прячем элементы
    override func hideElements(animated: Bool = true) {
        dataLabel.alpha = 0
        infoLabel.alpha = 0
        updateButton.alpha = 0
    }
    
    override func showElements(animated: Bool = true) {
        dataLabel.alpha = 1
        infoLabel.alpha = 1
        updateButton.alpha = 1
    }
}
