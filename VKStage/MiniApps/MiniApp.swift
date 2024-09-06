//
//  MiniApp.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import UIKit
import SnapKit
import CoreGraphics

//Шаблонный класс, тут только айди и поведение значка
class MiniApp: UIView, MiniAppProtocol{
    var id = UUID()
    var iconView = UIImageView()
    
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    func setup(){
        self.addSubview(iconView)
        iconView.snp.makeConstraints { maker in
            maker.bottom.leading.equalToSuperview().inset(10)
        }
        iconView.tintColor = .systemBackground
        iconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .semibold)
        setMinSize(animated: true)
    }
    
    //MARK: - MiniApp Protocol
    
    func setMinSize(animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.setNeedsLayout()
            self.iconView.snp.remakeConstraints { maker in
                maker.center.equalToSuperview()
            }
            self.layoutIfNeeded()
        })
        //Здесь разделил, чтобы приложение скрывало вьюшки раньше, чем иконка придет в центр
        UIView.animate(withDuration: animated ? 0.3: 0, animations: {
            self.setNeedsLayout()
            self.hideElements()
            self.layoutIfNeeded()
        })
    }
    
    func setHalfSize(animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.setNeedsLayout()
            self.showElements()
            self.iconView.snp.remakeConstraints { maker in
                maker.bottom.leading.equalToSuperview().inset(10)
            }
            self.layoutIfNeeded()
        })
    }
    
    func setFullSize(animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.setNeedsLayout()
            self.showElements()
            self.iconView.snp.remakeConstraints { maker in
                maker.center.equalToSuperview()
            }
            self.layoutIfNeeded()
        })
    }
    
    //MARK: - Показываем или прячем элементы при сворачиввании
    internal func showElements(animated: Bool = true){
        
    }
    
    internal func hideElements(animated: Bool = true){
        
    }
    
}
