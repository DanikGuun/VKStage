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
    
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    override func setup() {
        filter = CIFilter.sepiaTone()
        startGradientColor = .sepiaFilterStartGradient
        endGradienColor = .sepiaFilterEndGradient
        super.setup()
        filterNameLabel.text = "Сепия"
    }
    
}
