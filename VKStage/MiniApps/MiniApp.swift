//
//  MiniApp.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import Foundation
import UIKit

class MiniApp: UIView, MiniAppProtocol, Identifiable{
    
    var id = UUID()
    
    /** Необходимо для расширения родительской вью.
     Если родительскую вью изменять не нужно, оставьте nil
     */
    
    func setMinSize(animated: Bool = true) {
    }
    
    func setHalfSize(animated: Bool = true) {
    }
    
    func setFullSize(animated: Bool = true) {
    }
    
    
}
