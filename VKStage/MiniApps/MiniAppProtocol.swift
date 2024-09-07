//
//  MiniAppProtocol.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import Foundation
import UIKit

protocol MiniAppProtocol: Identifiable where Self: UIView{
    var id: UUID { get set }
    var currentState: MiniAppCurrentSize { get set}
    var delegate: MiniAppDelegate? { get set }
    func setMinSize(animated: Bool)
    func setHalfSize(animated: Bool)
    func setFullSize(animated: Bool)
}


enum MiniAppCurrentSize{
    case minimum
    case half
    case full
}
