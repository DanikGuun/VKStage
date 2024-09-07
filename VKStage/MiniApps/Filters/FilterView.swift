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
import CoreGraphics
import PhotosUI

class FilterView: MiniApp, PHPickerViewControllerDelegate{
    var startGradientColor: UIColor = .mainFilterStartGradient
    var endGradienColor: UIColor = .mainFilterEndGradient
    var image = UIImage() { didSet { applyFilter(value: filterIntensitySlider.value) } }
    
    internal var filterNameLabel = UILabel()
    internal var imageView = UIImageView(frame: .zero)
    
    private var getPhotoButton = UIButton()
    private var filterIntensitySlider = UISlider()
    private weak var viewController: UIViewController? {
        var responder: UIResponder? = self
        while responder?.next != nil{
            if let controller = responder as? UIViewController { return controller }
            responder = responder?.next
        }
        return nil
    }

    //MARK: - Initialize
    override func setup() {
        super.setup()
        iconView.image = UIImage(systemName: "camera.filters")
        
        self.addSubview(filterNameLabel)
        filterNameLabel.text = "Имя фильтра"
        filterNameLabel.textColor = .systemBackground
        filterNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        filterNameLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(iconView.snp.centerY)
            maker.leading.equalTo(iconView.snp.trailing).offset(5)
        }
        
        self.addSubview(filterIntensitySlider)
        filterIntensitySlider.minimumValue = 0.0
        filterIntensitySlider.maximumValue = 1.0
        filterIntensitySlider.value = 0.0
        filterIntensitySlider.addAction(UIAction(handler: { act in
            self.applyFilter(value: self.filterIntensitySlider.value)
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
        image = UIImage(named: "CuteCat")!
        
        self.addSubview(getPhotoButton)
        let photoIconConf = UIImage.SymbolConfiguration(pointSize: 26, weight: .semibold)
        let photoIcon = UIImage(systemName: "photo.stack", withConfiguration: photoIconConf)
        getPhotoButton.setImage(photoIcon, for: .normal)
        getPhotoButton.snp.makeConstraints { maker in
            maker.trailing.bottom.equalToSuperview().inset(20)
        }
        getPhotoButton.addAction(UIAction(handler: {_ in self.getPhotoFromLibrary() }), for: .touchUpInside)
    }
    
    //MARK: - Filtering
    internal func applyFilter(value: Float){} //для наследования
    
    //MARK: - Photo Library
    private func getPhotoFromLibrary(){
        guard let controller = viewController else { return }
        var conf = PHPickerConfiguration()
        conf.filter = .images
        conf.selectionLimit = 1
        let picker = PHPickerViewController(configuration: conf)
        picker.delegate = self
        controller.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let photoProvider = results.first?.itemProvider else { return }
        guard let viewController = viewController else { return }
        if photoProvider.canLoadObject(ofClass: UIImage.self){
            photoProvider.loadObject(ofClass: UIImage.self, completionHandler: {(item, error) in
                Task(priority: .high, operation: {
                    await MainActor.run{
                        if error == nil{
                            let img = item as! UIImage
                            self.image = img
                        }
                        else {print(error!)}
                    }
                })
            })
        }
        viewController.dismiss(animated: true)
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
        getPhotoButton.alpha = 0
    }
    override func showElements(animated: Bool = true) {
        filterIntensitySlider.alpha = 1
        imageView.alpha = 1
        getPhotoButton.alpha = 1
    }
    
}
