//
//  SecondTimerAppView.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation

class SecondTimerAppView: TimerAppView{
    override func setup() {
        self.startGradientColor = .secondTimer
        self.endGradientColor = .secondTimer
        self.timerTextColor = .secondTimerText
        self.timerTextHighlitedColor = .secondTimerTextHighlited
        self.timePickerBackgroundColor = .secondTimerBackground
        self.timePickerBackgroundHiglitedColor = .secondTimerBackgroundHighlited
        self.timer.timerBackColor = .secondTimerBack
        self.timer.timerColor = .secondTimer
        super.setup()
    }
}
