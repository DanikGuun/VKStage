//
//  KaleidoscopeFilterView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit

class PixelFilterView: FilterView{
    
    var filter = CIFilter.pixellate()
    
    override func setup() {
        super.setup()
        name = "Пиксели"
        filterNameLabel.text = "Пиксели"
    }
    override func applyFilter(value: Float) {
        filter.inputImage = CIImage(image: image)
        
        filter.scale = max(0.001, value*30)
    
        guard let outputImage = filter.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
