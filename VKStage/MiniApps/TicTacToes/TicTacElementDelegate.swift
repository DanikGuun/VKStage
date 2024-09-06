//
//  TicTacFieldDelegate.swift
//  VKStage
//
//  Created by Данила Бондарь on 06.09.2024.
//

import Foundation

protocol TicTacElementDelegate{
    /**
     Обрабатывает нажатие на поле
     - Parameters:
     - type: текущий тип ячейки
     - Returns: тип, который примет ячейка после нажатия
     */
    func performStep(_ type: TicTacCellType) -> TicTacCellType
}
