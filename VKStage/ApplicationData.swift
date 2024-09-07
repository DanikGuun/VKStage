//
//  AppData.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import Foundation
import UIKit

var AppData = ApplicationData()

struct ApplicationData{
    fileprivate init(){}
    
    var miniAppsDataSource: UICollectionViewDiffableDataSource<Section, UUID>?
    var apps: [any MiniAppProtocol] = [TemperatureView(), LocationView(), TicTacView(), SepiaFilterView()]
}

enum Section{
    case main
}
