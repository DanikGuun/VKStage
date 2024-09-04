//
//  MiniApp.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import Foundation
import UIKit

class MiniApp: UIView, MiniAppProtocol{
    var needResize: Bool = false
    
    func hide(animated: Bool = true) {
        guard needResize else { return }
        
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.bounds.size = CGSize(width: self.window?.screen.bounds.width ?? 0, height: 0)
        })
    }
    
    func setHalfSize(animated: Bool = true) {
        guard needResize else { return }
        
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.bounds.size = CGSize(width: self.window?.screen.bounds.width ?? 0, height: (self.window?.screen.bounds.height ?? 0) / 2)
        })
    }
    
    func setFullSize(animated: Bool = true) {
        guard needResize else { return }
        
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.bounds.size = CGSize(width: self.window?.screen.bounds.width ?? 0, height: self.window?.screen.bounds.height ?? 0)
        })
    }
    
    
}
