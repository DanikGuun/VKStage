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
    
    var startGradientColor: UIColor = .timerGradientStart { didSet { self.setNeedsDisplay() } }
    var endGradientColor: UIColor = .timerGradientEnd { didSet { self.setNeedsDisplay() } }
    var timePickerBackgroundColor: UIColor = .timePickerBackground
    var timePickerBackgroundHiglitedColor: UIColor = .timePickerBackgroundHighlited
    var timerTextColor: UIColor = .timerText
    var timerTextHighlitedColor: UIColor = .timerTextHighlited
    
    var timer: TimerView = TimerView()
    var timePickerButton: UIButton = UIButton()
    var timerControllerButton = UIButton()
    
    private var timePicker = UIPickerView()
    private var secondsTimer = Timer()
    private var currentSeconds: Int = 0 //сам четчик секунд
    private var startSeconds: Int = 0 //изначальный счетчик чтобы считать пропорцию
    private var currentTime: (hours: Int, minutes: Int, seconds: Int){
        let hours = currentSeconds / 3600
        let minutes = (currentSeconds - hours * 3600) / 60
        let seconds = currentSeconds - hours * 3600 - minutes * 60
        return (hours, minutes, seconds)
    }
    
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
                conf.background.backgroundColor = self.timePickerBackgroundColor
                conf.baseForegroundColor = self.timerTextColor
            }
            else if button.state == .selected{
                conf.background.backgroundColor = self.timePickerBackgroundHiglitedColor
                conf.baseForegroundColor = self.timerTextHighlitedColor
            }
            button.configuration = conf
        }
        timePickerButton.addAction(UIAction(handler: { [unowned self] _ in
            if timePickerButton.isSelected { showPicker() }
            else { hidePicker() }
        }), for: .touchUpInside)
        timePickerButton.snp.makeConstraints { maker in
            maker.center.equalTo(timer.snp.center)
            maker.size.equalTo(CGSize(width: 100, height: 30))
        }
        
        self.addSubview(timePicker)
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.snp.makeConstraints { maker in
            maker.top.equalTo(timePickerButton.snp.bottom)
            maker.bottom.leading.trailing.equalToSuperview()
        }
        timePicker.alpha = 0
        
        self.addSubview(timerControllerButton)
        timerControllerButton.changesSelectionAsPrimaryAction = true
        timerControllerButton.configuration = UIButton.Configuration.tinted()
        timerControllerButton.configurationUpdateHandler = { button in
            var conf = button.configuration!
            if button.state == .normal{
                conf.background.backgroundColor = self.timePickerBackgroundColor
                conf.baseForegroundColor = self.timerTextColor
                conf.title = "Стоп"
                conf.image = UIImage(systemName: "pause.fill")
            }
            else if button.state == .selected{
                conf.background.backgroundColor = self.timePickerBackgroundHiglitedColor
                conf.baseForegroundColor = self.timerTextHighlitedColor
                conf.title = "Продолжить"
                conf.image = UIImage(systemName: "arrowtriangle.right.fill")
            }
            button.configuration = conf
        }
        timerControllerButton.isSelected = true
        timerControllerButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(15)
        }
        timerControllerButton.addAction(UIAction(handler: {  _ in
            if self.timerControllerButton.isSelected == false { self.startTimer() }
            else { self.stopTimer() }
        }), for: .touchUpInside)
    }
    
    //MARK: - Seconds Timer
    private func startTimer(){
        guard currentSeconds > 0 else { return }
        secondsTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] time in
            currentSeconds -= 1
            timer.progress = CGFloat(currentSeconds) / CGFloat(startSeconds)
            updateTime()
            if currentSeconds <= 0 {
                time.invalidate()
                timerControllerButton.isSelected = true
            }
        })
    }
    
    private func stopTimer(){
        secondsTimer.invalidate()
    }
    
    private func updateTime(){
        var conf = timePickerButton.configuration
        conf?.title = "\(currentTime.hours):\(currentTime.minutes):\(currentTime.seconds)"
        timePickerButton.configuration = conf
        
        timePicker.selectRow(currentTime.hours, inComponent: 0, animated: true)
        timePicker.selectRow(currentTime.minutes, inComponent: 1, animated: true)
        timePicker.selectRow(currentTime.seconds, inComponent: 2, animated: true)
    }
    
    //MARK: - Time Picker
    func showPicker(){
        UIView.animate(withDuration: 0.3, animations: {
            self.timePicker.alpha = 1
            self.timerControllerButton.alpha = 0
        })
    }
    
    func hidePicker(){
        UIView.animate(withDuration: 0.3, animations: {
            self.timePicker.alpha = 0
            self.timerControllerButton.alpha = 1
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
        currentSeconds = pickerView.selectedRow(inComponent: 0) * 3600
        currentSeconds += pickerView.selectedRow(inComponent: 1) * 60
        currentSeconds += pickerView.selectedRow(inComponent: 2)
        startSeconds = currentSeconds
        timer.progress = 1.0
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
        timerControllerButton.alpha = 0
        timePickerButton.isSelected = false
    }
    
    override func showElements(animated: Bool = true) {
        timer.alpha = 1
        timePickerButton.alpha = 1
        timerControllerButton.alpha = 1
    }
    

    
}
