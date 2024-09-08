//
//  CartoonFilterView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit

class CartoonFilterView: FilterView{
    
    var filter = CIFilter.colorMonochrome()
    
    override func setup() {
        super.setup()
        name = "Мультик"
        filterNameLabel.text = "Мультик"
    }
    override func applyFilter(value: Float) {
        filter.inputImage = CIImage(image: image)
        
        filter.color = CIColor(red: 0, green: 0, blue: 0)
        filter.intensity = value
    
        guard let outputImage = filter.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
}
