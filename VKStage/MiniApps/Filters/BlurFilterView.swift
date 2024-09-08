//
//  File.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

class BlurFilterView: FilterView{
    
    private var filter = CIFilter.motionBlur()
    
    override func setup() {
        super.setup()
        name = "Размытие"
        filterNameLabel.text = "Размытие"
    }
    override func applyFilter(value: Float) {
        filter.inputImage = CIImage(image: image)
    
        filter.angle = 0
        filter.radius = value * 10
        
        guard let outputImage = filter.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
}
