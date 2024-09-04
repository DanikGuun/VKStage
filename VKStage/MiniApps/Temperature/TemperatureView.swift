//
//  TemperatureView.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import UIKit
import CoreGraphics

final class TemperatureView: UIView, MiniAppProtocol {
    var id = UUID()
    
    func setMinSize(animated: Bool) {
        
    }
    
    func setHalfSize(animated: Bool) {
        
    }
    
    func setFullSize(animated: Bool) {
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //Gradient Drawing
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let color = [CGColor(red: 46/255, green: 156/255, blue: 240/255, alpha: 1), CGColor(red: 63/255, green: 181/255, blue: 192/255, alpha: 1)]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: color as CFArray, locations: [0.0, 1.0]) else { return }
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: rect.height), options: [])
        //
    }

}
