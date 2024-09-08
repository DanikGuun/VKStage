//
//  TimerView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit
import SnapKit
import CoreGraphics

class TimerAppView: MiniApp, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var startGradientColor: UIColor = .timerGradientStart
    var endGradientColor: UIColor = .timerGradientEnd
    var timer: TimerView = TimerView()
    var timePickerButton: UIButton = UIButton()
    var timerControllerButton = UIButton()
    
    private var timePicker = UIPickerView()
    
    override func setup() {
        super.setup()
        
        iconView.image = UIImage(systemName: "timer")
        
        self.addSubview(timer)
        timer.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-30)
            maker.size.equalToSuperview().multipliedBy(0.8)
        }
        
        self.addSubview(timePickerButton)
        timePickerButton.changesSelectionAsPrimaryAction = true
        var conf = UIButton.Configuration.tinted()
        conf.title = "00:00:00"
        timePickerButton.configuration = conf
        timePickerButton.configurationUpdateHandler = { button in
            var conf = button.configuration!
            if button.state == .normal{
                conf.background.backgroundColor = .timePickerBackground
                conf.baseForegroundColor = .timerText
            }
            else if button.state == .selected{
                conf.background.backgroundColor = .timePickerBackgroundHighlited
                conf.baseForegroundColor = .timerTextHighlited
            }
            button.configuration = conf
        }
        timePickerButton.addAction(UIAction(handler: { [unowned self] _ in
            if timePickerButton.isSelected { showPicker() }
            else { hidePicker() }
        }), for: .touchUpInside)
        
        timePickerButton.snp.makeConstraints { maker in
            maker.center.equalTo(timer.snp.center)
        }
        
        self.addSubview(timePicker)
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.snp.makeConstraints { maker in
            maker.top.equalTo(timePickerButton.snp.bottom)
            maker.bottom.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(timerControllerButton)
        timerControllerButton.changesSelectionAsPrimaryAction = true
        var conf2 = UIButton.Configuration.tinted()
        conf2.title = "Продолжить"
        conf2.image = UIImage(systemName: "arrowtriangle.right.fill")
        timerControllerButton.configuration = conf2
        timerControllerButton.configurationUpdateHandler = { button in
            var conf = button.configuration!
            if button.state == .normal{
                conf.background.backgroundColor = .timePickerBackground
                conf.baseForegroundColor = .timerText
                conf.title = "Стоп"
                conf.image = UIImage(systemName: "pause.fill")
            }
            else if button.state == .selected{
                conf.background.backgroundColor = .timePickerBackgroundHighlited
                conf.baseForegroundColor = .timerTextHighlited
                conf.title = "Продолжить"
                conf.image = UIImage(systemName: "arrowtriangle.right.fill")
            }
            button.configuration = conf
        }
        timerControllerButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(15)
        }
        timerControllerButton.addAction(UIAction(handler: { [unowned self] _ in

        }), for: .touchUpInside)
        
        
        self.setHalfSize() //fasdfa
    }
    
    //MARK: - Time Picker
    func showPicker(){
        UIView.animate(withDuration: 0.3, animations: {
            self.timePicker.alpha = 1
        })
    }
    func hidePicker(){
        UIView.animate(withDuration: 0.3, animations: {
            self.timePicker.alpha = 0
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0: return 24
        case 1, 2: return 60
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row.description
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var conf = timePickerButton.configuration
        conf?.title = "\(pickerView.selectedRow(inComponent: 0)):\(pickerView.selectedRow(inComponent: 1)):\(pickerView.selectedRow(inComponent: 2))"
        timePickerButton.configuration = conf
    }
    
    //MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //Gradient
        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
        let colors = [startGradientColor.cgColor, endGradientColor.cgColor]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 1.0]) else { return }
        
        context.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 0, y: rect.height), options: [])
        //
        
    }
    
    //MARK: - Resizing
    override func setMinSize(animated: Bool = true) {
        super.setMinSize(animated: animated)
    }
    
    override func setHalfSize(animated: Bool = true) {
        super.setHalfSize(animated: animated)
        timer.setNeedsDisplay()
    }
    
    override func hideElements(animated: Bool = true) {
        timer.alpha = 0
        timePicker.alpha = 0
        timePickerButton.alpha = 0
    }
    
    override func showElements(animated: Bool = true) {
        timer.alpha = 1
        timePicker.alpha = 1
        timePickerButton.alpha = 1
    }
}
