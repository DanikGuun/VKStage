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
class MiniApp: UIControl, MiniAppProtocol{
    var id = UUID()
    var iconView = UIImageView()
    var currentState: MiniAppCurrentSize = .minimum
    var delegate: (any MiniAppDelegate)?
    
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    func setup(){
        self.addSubview(iconView)
        iconView.snp.makeConstraints { maker in
            maker.bottom.leading.equalToSuperview().inset(10)
            maker.height.equalTo(self.snp.width)
        }
        iconView.tintColor = .systemBackground
        iconView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .semibold)
        setMinSize(animated: true)
        
        self.addAction(UIAction(handler: {_ in self.changeSize()}), for: .touchUpInside)
    }
    
    //MARK: - Change Size
    func changeSize(){
        if currentState == .minimum { setHalfSize() }
        else if currentState == .half { setMinSize() }
        if let delegate = delegate{
            delegate.miniApp(hasChangeSizeWith: currentState)
        }
    }
    
    //MARK: - MiniApp Protocol
    
    func setMinSize(animated: Bool = true) {
        currentState = .minimum
        if let delegate = delegate { delegate.miniApp(hasChangeSizeWith: currentState) }
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
        currentState = .half
        if let delegate = delegate { delegate.miniApp(hasChangeSizeWith: currentState) }
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
        currentState = .full
        if let delegate = delegate { delegate.miniApp(hasChangeSizeWith: currentState) }
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

