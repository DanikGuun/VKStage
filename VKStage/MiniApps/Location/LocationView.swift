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
        
        name = "Местополжение"
        iconView.image = UIImage(systemName: "building.2.fill")
        
        infoLabel.text = "Ваш примерный адрес:"
        infoLabel.font = UIFont.systemFont(ofSize: 36)
        dataLabel.font = UIFont.systemFont(ofSize: 24)
        
        updateButtonHandler = {
            Task(priority: .userInitiated){
                if let city = await LocationModel.getCurrentCity(){
                    await MainActor.run{
                        self.dataLabel.text = "\(city)"
                    }
                }
                else {
                    let alert = UIAlertController(title: "Произошла ошибка получения адреса(", message: "Скорее всего вы не дали разрешение на использование местоположения, либо у вас нет доступа к интернету", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    await MainActor.run{
                        self.viewController?.present(alert, animated: true)
                    }
                }
            }
        }
        
        if let update = updateButtonHandler { update() }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //Gradient drawing
        let space = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [UIColor.locationStartGradien.cgColor, UIColor.locationEndGradien.cgColor]
        
        guard let gradient = CGGradient(colorsSpace: space, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: rect.height), options: [])
        //
    }
    
}
