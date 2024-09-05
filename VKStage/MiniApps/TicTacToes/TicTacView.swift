//
//  TicTacView.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import UIKit
import CoreGraphics

class TicTacView: MiniApp {

    override func setup() {
        super.setup()
        iconView.image = UIImage(named: "TicTacToesIcon")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [CGColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1), CGColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1)]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
    }
}
