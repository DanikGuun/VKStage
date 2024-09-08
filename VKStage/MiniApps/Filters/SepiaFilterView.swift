//
//  SepiaFilterView.swift
//  VKStage
//
//  Created by Данила Бондарь on 07.09.2024.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

class SepiaFilterView: FilterView{
    
    private var filter = CIFilter.sepiaTone()
    
    override func setup() {
        name = "Сепия"
        startGradientColor = .sepiaFilterStartGradient
        endGradienColor = .sepiaFilterEndGradient
        super.setup()
        filterNameLabel.text = "Сепия"
    }
    override func applyFilter(value: Float) {
        filter.inputImage = CIImage(image: image)
        filter.intensity = value
        
        guard let outputImage = filter.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
}
