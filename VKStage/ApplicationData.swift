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

    var miniAppsDataSource: UICollectionViewDiffableDataSource<Section, UUID>?
    var apps: [any MiniAppProtocol] = [TimerAppView(), TemperatureView(), LocationView(), TicTacView(), NewTicTackView(), SepiaFilterView(), DisterFilterView(), HatchedFilterView(), BlurFilterView(), PixelFilterView()]
}

enum Section{
    case main
}
