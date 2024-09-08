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
    var tableAppsDataSource: UITableViewDiffableDataSource<Section, UUID>?
    var apps: [any MiniAppProtocol] = [TemperatureView(), LocationView(), TicTacView(), NewTicTackView(), SepiaFilterView(), DisterFilterView(), HatchedFilterView(), BlurFilterView(), PixelFilterView(), TimerAppView(), SecondTimerAppView()]
    
    //чтобы перерисовывать всьюшки при изменении экрана
    func setNeedsDisplayForSubviews(){
        AppData.apps.forEach { $0.subviews.forEach {$0.setNeedsDisplay()} }
    }
}

enum Section{
    case main
}
