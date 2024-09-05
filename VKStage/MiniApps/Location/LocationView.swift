//
//  LocationView.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import Foundation
import UIKit
import CoreGraphics

class LocationView: InfoMiniAppView{

    override func setup() {
        super.setup()

        iconView.image = UIImage(systemName: "building.2.fill")
        
        infoLabel.text = "Ваш город:"
        dataLabel.text = LocationModel.getCurrentCity()
        updateButtonHandler = {
            self.dataLabel.text = LocationModel.getCurrentCity()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //Gradient drawing
        let space = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [CGColor(red: 144/255, green: 95/255, blue: 228/255, alpha: 1), CGColor(red: 100/255, green: 32/255, blue: 217/255, alpha: 1)]
        
        guard let gradient = CGGradient(colorsSpace: space, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: rect.height), options: [])
        //
    }
    
}
