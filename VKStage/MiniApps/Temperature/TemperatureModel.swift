//
//  TemperatureModel.swift
//  VKStage
//
//  Created by Данила Бондарь on 05.09.2024.
//

import Foundation

final class TemperatureModel{
    static func getTemperature() -> Double{
        return [15.2, 62.3, 10.8, 3.6, 35].randomElement()!
    }
}
