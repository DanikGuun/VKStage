//
//  HZFilter.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit

class HatchedFilterView: FilterView{
    
    private var filter = CIFilter.hatchedScreen()
    
    override func setup() {
        super.setup()
        name = "Сетка"
        filterNameLabel.text = "Сетка"
    }
    override func applyFilter(value: Float) {
        filter.inputImage = CIImage(image: image)
        
        filter.angle = 45
        filter.sharpness = value
        filter.width = max(value, 0.001) * 10
        
        guard let outputImage = filter.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
}
