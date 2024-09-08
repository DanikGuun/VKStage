//
//  GlassFilterView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit

class DisterFilterView: FilterView{
    
    private var filter = CIFilter.dither()
    
    override func setup() {
        super.setup()
        name = "Шум"
        filterNameLabel.text = "Шум"
    }
    
    override func applyFilter(value: Float) {
        filter.inputImage = CIImage(image: image)
        filter.intensity = value
    
        guard let outputImage = filter.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
}
