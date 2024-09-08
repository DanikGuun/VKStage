//
//  SplitTableViewController.swift
//  VKStage
//
//  Created by Данила Бондарь on 08.09.2024.
//

import Foundation
import UIKit

class SplitTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupDataSource()
        setupSnapshot()
    }
    
    //MARK: - Table View
    
    private func setupDataSource(){
        AppData.tableAppsDataSource = UITableViewDiffableDataSource<Section, UUID>(tableView: tableView, cellProvider: { (tableView, indexPath, id) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if let app = AppData.apps.first(where: { $0.id == id }) as? MiniApp{
                var conf = cell.defaultContentConfiguration()
                conf.image = app.iconView.image
                conf.text = app.name
                conf.imageProperties.maximumSize = CGSize(width: 30, height: 30)
                cell.contentConfiguration = conf
            }
            return cell
        })
    }
    
    private func setupSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, UUID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(AppData.apps.map { $0.id })
        AppData.tableAppsDataSource?.apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = AppData.tableAppsDataSource?.itemIdentifier(for: indexPath) else { return }
        if let miniAppView = AppData.apps.first(where: { $0.id == id }) as? MiniApp{
            splitViewController?.hide(.primary)
            let controller = splitViewController!.viewController(for: .secondary)!
            controller.view.subviews.forEach { $0.removeFromSuperview() }
            controller.view.addSubview(miniAppView)
            miniAppView.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            miniAppView.setFullSize(animated: false)
        }
    }
}
