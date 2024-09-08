//
//  FullScreenViewController.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import UIKit
import SnapKit

class FullScreenViewController: UIViewController{

    var miniAppView: MiniApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = miniAppView?.name
        if let app = miniAppView{
            self.view.addSubview(app)
            app.subviews.first(where: {$0.restorationIdentifier == "fullButton"} )?.isHidden = true
            app.setFullSize(animated: true)
            app.snp.makeConstraints { maker in
                maker.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
            }
        }
    }

}
