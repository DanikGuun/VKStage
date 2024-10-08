//
//  TicTacElementView.swift
//  VKStage
//
//  Created by Данила Бондарь on 06.09.2024.
//

import Foundation
import UIKit
import CoreGraphics

class TicTacElementView: UIControl{
    
    var delegate: TicTacElementDelegate?
    var cellType: TicTacCellType = .none { didSet { setNeedsDisplay() } }
    var margin: CGFloat = 0  { didSet { setNeedsDisplay() } } //если надо сделать с отступом
    var lineWidth: CGFloat = 10 { didSet { setNeedsDisplay() } }
    var ticColor: UIColor = .tic { didSet { setNeedsDisplay() } }
    var tacColor: UIColor = .tac { didSet { setNeedsDisplay() } }
    var position: Int = 0
    
    //MARK: - Initialiaze
    convenience init(){
        self.init(frame: .zero)
        self.addAction(UIAction(handler: { [unowned self] _ in
            if let delegate = delegate{
                cellType = delegate.ticTacElement(prepareToStepWith: cellType, withPosition: position)
            }
        }), for: .touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        func drawCircle(at point: CGPoint, for path: UIBezierPath){
            path.addArc(withCenter: point, radius: lineWidth/2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        }
        
        //отдельно рисуем, чтобы потом просто анимировать
        let width = self.bounds.width
        let height = self.bounds.height
        
        //рисуем слой для крестика
        if cellType == .tic{
            ticColor.setStroke()
            ticColor.setFill()
            
            let ticPath1 = UIBezierPath()
            ticPath1.lineWidth = lineWidth
            
            ticPath1.move(to: CGPoint(x: 0 + margin + lineWidth/2, y: 0 + margin + lineWidth/2))
            ticPath1.addLine(to: CGPoint(x: width - margin - lineWidth/2, y: height - margin - lineWidth/2))
            ticPath1.stroke()
            
            drawCircle(at: CGPoint(x: 0 + margin + lineWidth/2, y: 0 + margin + lineWidth/2), for: ticPath1)
            drawCircle(at: CGPoint(x: width - margin - lineWidth/2, y: height - margin - lineWidth/2), for: ticPath1)
            ticPath1.fill()
            
            let ticPath2 = UIBezierPath()
            ticPath2.lineWidth = lineWidth
            
            ticPath2.move(to: CGPoint(x: 0 + margin + lineWidth/2, y: height - margin - lineWidth/2))
            ticPath2.addLine(to: CGPoint(x: width - margin - lineWidth/2, y: 0 + margin + lineWidth/2))
            ticPath2.stroke()
            
            drawCircle(at: CGPoint(x: 0 + margin + lineWidth/2, y: height - margin - lineWidth/2), for: ticPath2)
            drawCircle(at: CGPoint(x: width - margin - lineWidth/2, y: 0 + margin + lineWidth/2), for: ticPath2)
            ticPath2.fill()
        }
        
        else if cellType == .tac{
            tacColor.setStroke()
            
            let tacPath = UIBezierPath()
            tacPath.lineWidth = lineWidth
            
            tacPath.addArc(withCenter: CGPoint(x: width/2, y: height/2), radius: min(width, height)/2 - margin - lineWidth/2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            tacPath.stroke()
        }
        //
        
        //рисуем слой для нолика
    
    }
}

enum TicTacCellType{
    case tic
    case tac
    case none
    
    mutating func toggle(){
        if self != .none{
            self = self == .tac ? .tic : .tac
        }
    }
}
