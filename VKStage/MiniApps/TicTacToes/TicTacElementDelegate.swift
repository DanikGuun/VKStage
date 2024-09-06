//
//  TicTacFieldDelegate.swift
//  VKStage
//
//  Created by Данила Бондарь on 06.09.2024.
//

import Foundation

protocol TicTacElementDelegate{
    func performStep() -> TicTacFieldType
}
