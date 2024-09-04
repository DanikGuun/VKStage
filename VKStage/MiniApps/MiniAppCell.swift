//
//  MiniAppCell.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import UIKit
import SnapKit

class MiniAppCell: UICollectionViewListCell {
    
    private var _miniApp: (any MiniAppProtocol)?
    var miniApp: (any MiniAppProtocol)?{
        get { return _miniApp }
        set{
            //заменяем miniapp на новый, удаляя предыдущие
            guard let app = newValue else { return }
            self.subviews.forEach {$0.removeFromSuperview()}
            self.addSubview(app)
            app.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            self._miniApp = app
        }
    }
    
}
