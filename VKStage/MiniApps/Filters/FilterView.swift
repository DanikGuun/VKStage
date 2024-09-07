//
//  FilterView.swift
//  VKStage
//
//  Created by Данила Бондарь on 07.09.2024.
//

import Foundation
import UIKit
import SnapKit
import CoreImage
import CoreImage.CIFilterBuiltins
import CoreGraphics

class FilterView: MiniApp{
    var startGradientColor: UIColor = .mainFilterStartGradient
    var endGradienColor: UIColor = .mainFilterEndGradient
    var filter: CIFilter?
    var image = UIImage() { didSet { applyFilter(intensity: filterIntensitySlider.value) } }
    
    internal var filterNameLabel = UILabel()
    
    private var imageView = UIImageView(frame: .zero)
    private var filterIntensitySlider = UISlider()

    //MARK: - Initialize
    override func setup() {
        super.setup()
        iconView.image = UIImage(systemName: "camera.filters")
        
        self.addSubview(filterNameLabel)
        filterNameLabel.text = "Имя фильтра"
        filterNameLabel.textColor = .systemBackground
        filterNameLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(iconView.snp.centerY)
            maker.leading.equalTo(iconView.snp.trailing)
        }
        
        self.addSubview(filterIntensitySlider)
        filterIntensitySlider.minimumValue = 0.0
        filterIntensitySlider.maximumValue = 1.0
        filterIntensitySlider.value = 0.0
        filterIntensitySlider.addAction(UIAction(handler: { act in
            self.applyFilter(intensity: self.filterIntensitySlider.value)
        }), for: .valueChanged)
        filterIntensitySlider.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(20)
            maker.bottom.equalTo(iconView.snp.top).offset(-10)
        }
        
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(15)
            maker.centerX.equalToSuperview()
            maker.size.equalToSuperview().multipliedBy(0.7)
        }
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        image = UIImage(named: "CuteCat")!
    }
    
    //MARK: - Filtering
    private func applyFilter(intensity: Float){
        filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        filter?.setValue(intensity, forKey: kCIInputIntensityKey)
        
        guard let outputImage = filter?.outputImage else { return }
        imageView.image = UIImage(ciImage: outputImage)
    }
    
    //MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [startGradientColor.cgColor, endGradienColor.cgColor]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
    }
    
    //MARK: - MiniApp
    override func hideElements(animated: Bool = true) {
        filterIntensitySlider.alpha = 0
        imageView.alpha = 0
    }
    override func showElements(animated: Bool = true) {
        filterIntensitySlider.alpha = 1
        imageView.alpha = 1
    }
    
}
