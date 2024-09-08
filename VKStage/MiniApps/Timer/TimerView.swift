//
//  Timer.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit

class TimerView: UIView{
    var timerColor: UIColor = .timer { didSet { self.setNeedsDisplay() } }
    var timerBackColor: UIColor = .timerBack { didSet { self.setNeedsDisplay() } }
    var lineWidth: CGFloat = 7 { didSet { self.setNeedsDisplay() } }
    var progress: CGFloat = 1 { willSet { animateTimer(to: newValue) } }
    private var timerLayer = CAShapeLayer()
    private var timerBackLayer = CAShapeLayer() //чтобы одинаково анимировались
    
    convenience init(){
        self.init(frame: .zero)
        setup()
    }
    
    func setup(){
        self.layer.addSublayer(timerLayer)
        self.layer.addSublayer(timerBackLayer)
    }
    //MARK: - Drawing
    private func animateTimer(to value: CGFloat){
        let anim = CABasicAnimation()
        anim.keyPath = "strokeEnd"
        anim.fromValue = progress
        anim.toValue = value
        anim.duration = 1
        anim.isRemovedOnCompletion = false
        anim.fillMode = .forwards
        timerLayer.add(anim, forKey: "strokeEnd")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //рисовать по меньше стороне, AspectRatio
        let minEdge = min(self.bounds.width, self.bounds.height)
        
        //TimerTransparrentBack
        let timerBackPath = UIBezierPath()
        timerBackPath.lineWidth = lineWidth
        timerBackPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY), radius: minEdge/2 - lineWidth/2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        timerBackLayer.path = timerBackPath.cgPath
        timerBackLayer.strokeColor = timerBackColor.cgColor
        timerBackLayer.fillColor = UIColor.clear.cgColor
        timerBackLayer.lineWidth = lineWidth
        //
        
        //Timer
        let timerPath = UIBezierPath()
        timerPath.lineWidth = lineWidth
        timerPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY), radius: minEdge/2 - lineWidth/2, startAngle: -.pi / 2, endAngle: -.pi * 5/2 , clockwise: false)
        timerLayer.path = timerPath.cgPath
        timerLayer.strokeColor = timerColor.cgColor
        timerLayer.fillColor = UIColor.clear.cgColor
        timerLayer.strokeEnd = progress
        timerLayer.lineWidth = lineWidth
        //
    }
}
