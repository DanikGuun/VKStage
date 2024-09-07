//
//  TicTacView.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import UIKit
import CoreGraphics

class TicTacView: MiniApp, TicTacFieldDelegate {
    
    var ticTacField = TicTacFieldView()
    var currentStepLabel = UILabel()
    var currentStepIcon = TicTacElementView()
    
    override func setup() {
        self.addSubview(ticTacField)
        super.setup()
        iconView.image = UIImage(named: "TicTacToesIcon")
        
        ticTacField.backgroundColor = .clear
        ticTacField.delegate = self
        ticTacField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(1.05)
            maker.height.equalToSuperview().multipliedBy(0.67)
            maker.width.equalTo(ticTacField.snp.height)
        }
       
        self.addSubview(currentStepLabel)
        currentStepLabel.text = "Сейчас ходит"
        currentStepLabel.textColor = .systemBackground
        currentStepLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        currentStepLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(ticTacField.snp.top).inset(-17)
        }
        
        self.addSubview(currentStepIcon)
        currentStepIcon.backgroundColor = .clear
        currentStepIcon.cellType = .tic
        currentStepIcon.lineWidth = 6
        currentStepIcon.isUserInteractionEnabled = false
        currentStepIcon.snp.makeConstraints { maker in
            maker.leading.equalTo(currentStepLabel.snp.trailing).offset(10)
            maker.centerY.equalTo(currentStepLabel.snp.centerY)
            maker.height.width.equalTo(currentStepLabel.snp.height)
        }
        
    }
    
    //MARK: - TicTacField Delegate
    func ticTacField(performSetpWith type: TicTacCellType) {
        currentStepIcon.cellType = type
    }
    func ticTacField(winWith type: TicTacCellType, compelition: (()->())?) {
        ticTacField.isUserInteractionEnabled = false
        if type != .none{
            currentStepLabel.text = "Победили"
            currentStepIcon.cellType = type
        }
        else {
            currentStepLabel.text = "Ничья"
            currentStepIcon.cellType = .none
        }
        //сначала затухаение, всё стираем, потом небольшая задержка, потом поялвение и запуск интерактивности
        UIView.animate(withDuration: 0.5, delay: 1, animations: {
            self.ticTacField.alpha = 0
        }, completion: {_ in
            if let compelition { compelition() }
            UIView.animate(withDuration: 0.5, delay: 0.3, animations: {
                self.ticTacField.alpha = 1
            }, completion: {[unowned self] _ in
                ticTacField.isUserInteractionEnabled = true
                currentStepLabel.text = "Сейчас ходит"
                currentStepIcon.cellType = .tic
            })
        })
    }
    
    //MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [CGColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1), CGColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1)]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
    }
    
    //MARK: - Resizing
    
    override func setMinSize(animated: Bool = true) {
        super.setMinSize(animated: animated)
        
    }
    
    override func setHalfSize(animated: Bool = true) {
        super.setHalfSize(animated: animated)
        ticTacField.setNeedsDisplay()
    }
    
    override func setFullSize(animated: Bool = true) {
        super.setFullSize(animated: animated)
    }
    
    override func hideElements(animated: Bool = true) {
        super.hideElements(animated: animated)
        ticTacField.alpha = 0
        currentStepLabel.alpha = 0
        currentStepIcon.alpha = 0
    }
    
    override func showElements(animated: Bool = true) {
        super.showElements(animated: animated)
        ticTacField.alpha = 1
        currentStepLabel.alpha = 1
        currentStepIcon.alpha = 1
    }
}
