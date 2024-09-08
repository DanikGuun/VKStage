//
//  TimerView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit
import CoreGraphics

class TimerView: MiniApp{
    
    var startGradientColor: UIColor = .timerGradientStart
    var endGradientColor: UIColor = .timerGradientEnd
    
    override func setup() {
        super.setup()
        iconView.image = UIImage(systemName: "timer")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [startGradientColor.cgColor, endGradientColor.cgColor]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
        
    }
}
