//
//  SmallScreenViewControllers.swift
//  VKStage
//
//  Created by Данила Бондарь on 04.09.2024.
//

import UIKit

class SmallScreenViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var resizeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        setupCollectionView()
        setupDataSource()
        setupSnapshot()
        collectionView.delegate = self
        setupResizeButton()
    }

    //MARK: - ToolBar
    
    private func changeSizeButtonPressed(_ sender: UIButton) {
        let targetMultiplyer: CGFloat = sender.isSelected ? 1/2 : 1/8
        collectionView.setCollectionViewLayout(getLayout(multiplyer: targetMultiplyer), animated: true)
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
    private func setupCollectionView(){
        collectionView.collectionViewLayout = getLayout(multiplyer: 1/8)
    }
    
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
    
    private func getLayout(multiplyer: CGFloat) -> UICollectionViewCompositionalLayout{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item  = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(multiplyer))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(10))
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
