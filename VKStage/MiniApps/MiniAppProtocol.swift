//
//  MiniAppProtocol.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import Foundation
import UIKit

protocol MiniAppProtocol where Self: UIView{
    var needResize: Bool {get set} //Чтобы не менять размер на айпадах
    func hide(animated: Bool)
    func setHalfSize(animated: Bool)
    func setFullSize(animated: Bool)
}
