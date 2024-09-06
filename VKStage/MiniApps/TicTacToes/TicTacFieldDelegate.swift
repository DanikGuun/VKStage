//
//  TicTacFieldDelegate.swift
//  VKStage
//
//  Created by Данила Бондарь on 07.09.2024.
//

import Foundation

protocol TicTacFieldDelegate{
    func ticTacField(performSetpWith type: TicTacCellType)
    func ticTacField(winWith type: TicTacCellType, compelition: (()->())?)
}
