//
//  File.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import Foundation
import UIKit
import CoreGraphics

class TicTacFieldView: UIView{
    
    var fieldColor: UIColor = .systemBackground{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //для рисования закруглений на конце
        func drawCircle(at point: CGPoint, for path: UIBezierPath){
            path.addArc(withCenter: point, radius: lineWidth/2, startAngle: .pi / 2, endAngle: .pi * 5/2, clockwise: true)
        }
        
        let lineWidth: CGFloat = 7
        let minEdge = min(rect.width, rect.height) //чтобы рисоавть относительно центра, как будто aspectRatio
        
        fieldColor.setStroke()
        fieldColor.setFill()
        
        //смещаем на половину трети(так как поле делится на 3 равные части) минимальной из сторон(по 1/2 в каждую сторону)
        
        //
        let leftPath = UIBezierPath()
        leftPath.lineWidth = lineWidth
        
        leftPath.move(to: CGPoint(x: rect.midX - minEdge/3/2 , y: lineWidth/2))
        leftPath.addLine(to: CGPoint(x: rect.midX - minEdge/3/2, y: rect.height - lineWidth/2))
        leftPath.stroke()
        
        drawCircle(at: CGPoint(x: rect.midX - minEdge/3/2 , y: lineWidth/2), for: leftPath)
        drawCircle(at: CGPoint(x: rect.midX - minEdge/3/2, y: rect.height - lineWidth/2), for: leftPath)
        leftPath.fill()
        //
        
        //
        let rightPath = UIBezierPath()
        rightPath.lineWidth = 7
        
        rightPath.move(to: CGPoint(x: rect.midX + minEdge/3/2, y: lineWidth/2))
        rightPath.addLine(to: CGPoint(x: rect.midX + minEdge/3/2, y: rect.height - lineWidth/2))
        rightPath.stroke()
        
        drawCircle(at: CGPoint(x: rect.midX + minEdge/3/2, y: lineWidth/2), for: rightPath)
        drawCircle(at: CGPoint(x: rect.midX + minEdge/3/2, y: rect.height - lineWidth/2), for: rightPath)
        rightPath.fill()
        //
        
        //
        let upPath = UIBezierPath()
        upPath.lineWidth = 7
        
        upPath.move(to: CGPoint(x: rect.midX - minEdge/2 + lineWidth/2, y: rect.midY - minEdge/3/2))
        upPath.addLine(to: CGPoint(x: rect.midX + minEdge/2 - lineWidth/2, y: rect.midY - minEdge/3/2))
        upPath.stroke()
        
        drawCircle(at: CGPoint(x: rect.midX - minEdge/2 + lineWidth/2, y: rect.midY - minEdge/3/2), for: upPath)
        drawCircle(at: CGPoint(x: rect.midX + minEdge/2 - lineWidth/2, y: rect.midY - minEdge/3/2), for: upPath)
        upPath.fill()
        //
        
        //
        let downPath = UIBezierPath()
        downPath.lineWidth = 7
        
        downPath.move(to: CGPoint(x: rect.midX - minEdge/2 + lineWidth/2, y: rect.midY + minEdge/3/2))
        downPath.addLine(to: CGPoint(x: rect.midX + minEdge/2 - lineWidth/2, y: rect.midY + minEdge/3/2))
        downPath.stroke()
        
        drawCircle(at: CGPoint(x: rect.midX - minEdge/2 + lineWidth/2, y: rect.midY + minEdge/3/2), for: downPath)
        drawCircle(at: CGPoint(x: rect.midX + minEdge/2 - lineWidth/2, y: rect.midY + minEdge/3/2), for: downPath)
        downPath.fill()
        //
        
    }
}
