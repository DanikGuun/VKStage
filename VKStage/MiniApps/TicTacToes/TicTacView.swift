//
//  TicTacView.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import UIKit
import CoreGraphics

class TicTacView: MiniApp {

    var ticTacField = TicTacFieldView()
    
    override func setup() {
        self.addSubview(ticTacField)
        super.setup()
        iconView.image = UIImage(named: "TicTacToesIcon")
        
        ticTacField.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.67)
            maker.width.equalTo(ticTacField.snp.height)
        }
        ticTacField.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [CGColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1), CGColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1)]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
    }
    
    override func setMinSize(animated: Bool = true) {
        super.setMinSize(animated: animated)
    }
    
    override func setHalfSize(animated: Bool = true) {
        super.setHalfSize(animated: animated)
    }
    
    override func setFullSize(animated: Bool = true) {
        super.setFullSize(animated: animated)
    }
    
    override func hideElements(animated: Bool = true) {
        super.hideElements(animated: animated)
        ticTacField.alpha = 0
    }
    
    override func showElements(animated: Bool = true) {
        super.showElements(animated: animated)
        ticTacField.alpha = 1
        ticTacField.setNeedsDisplay()
    }
}
