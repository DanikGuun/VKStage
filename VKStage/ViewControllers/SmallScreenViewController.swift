//
//  SmallScreenViewControllers.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import UIKit

class SmallScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var resizeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        setupDataSource()
        setupSnapshot()
        collectionView.delegate = self
        setupResizeButton()
    }

    //MARK: - ToolBar
    
    private func changeSizeButtonPressed(_ sender: UIButton) {

        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut] ,animations: {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutIfNeeded()
        })
        
        AppData.apps.forEach {
            if sender.isSelected { $0.setHalfSize(animated: true) }
            else { $0.setMinSize(animated: true) }
        }
    }
    
    private func setupResizeButton(){
        resizeButton.changesSelectionAsPrimaryAction = true
        resizeButton.configurationUpdateHandler = { button in
            var conf = button.configuration
            conf?.background.backgroundColor = .clear
            conf?.baseForegroundColor = .systemBlue
            let imageName = button.isSelected ? "square.2.layers.3d.fill" : "square.2.layers.3d"
            conf?.image = UIImage(systemName: imageName)
            button.configuration = conf
        }
        resizeButton.addAction(UIAction(handler: {[unowned self] _ in self.changeSizeButtonPressed(resizeButton)}), for: .touchUpInside)
    }
    
    //MARK: - CollectionView
    
    private func setupDataSource(){
        let registrator = UICollectionView.CellRegistration<MiniAppCell, UUID>(handler: {(cell, indexPath, id) in
            if let app = AppData.apps.first(where: {$0.id == id}){
                cell.miniApp = app
            }
        })
        AppData.miniAppsDataSource = UICollectionViewDiffableDataSource<Section, UUID>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, id) in
            return collectionView.dequeueConfiguredReusableCell(using: registrator, for: indexPath, item: id)
        })
    }
    
    private func setupSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, UUID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(AppData.apps.map {$0.id})
        AppData.miniAppsDataSource?.apply(snapshot)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = resizeButton.isSelected ? collectionView.bounds.height / 2 : collectionView.bounds.height / 8
        return CGSize(width: width, height: height)
    }
}
