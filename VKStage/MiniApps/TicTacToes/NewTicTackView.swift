//
//  NewTicTackView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit

class NewTicTackView: TicTacView{
    override func setup() {
        super.setup()
        name = "Крестики нолики 2"
        startGradient = .newTicTacGradientStart
        endGradient = .newTicTacGradientEnd
        ticTacField.fieldColor = .newTicTacAccent
        ticTacField.ticTacElements.forEach {
            $0.ticColor = .newTic
            $0.tacColor = .newTac
        }
        currentStepIcon.ticColor = .newTic
        currentStepIcon.tacColor = .newTac
    }
}
