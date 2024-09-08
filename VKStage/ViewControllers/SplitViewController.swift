//
//  SplitController.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func splitViewController(_ svc: UISplitViewController, willHide column: UISplitViewController.Column) {
        AppData.setNeedsDisplayForSubviews()
    }
    func splitViewController(_ svc: UISplitViewController, willShow column: UISplitViewController.Column) {
        AppData.setNeedsDisplayForSubviews()
    }
}
