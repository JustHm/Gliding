//
//  ViewController.swift
//  Gliding
//
//  Created by 안정흠 on 3/4/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>
    var dataSource: DataSource?
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionView())
        
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
    }
    
    private func fetchCollectionViewData(data: [HomeSectionItem], section: HomeSection) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSectionItem>()
        snapshot.appendItems(data, toSection: section)
        dataSource?.apply(snapshot)
    }
    
    private func configureCollectionView() {
        let mainCellRegistration = UICollectionView.CellRegistration<MainProfileCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
            //            cell.configure()
        }
        let poolCellRegistration = UICollectionView.CellRegistration<PoolInfoCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
            //            cell.configure()
        }
        let tipCellRegistration = UICollectionView.CellRegistration<SwimTipCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
            //            cell.configure()
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch indexPath.section {
            case 0: // Main Statistic (Simple)
                collectionView.dequeueConfiguredReusableCell(using: mainCellRegistration, for: indexPath, item: itemIdentifier)
            case 1: // PoolInfo
                collectionView.dequeueConfiguredReusableCell(using: poolCellRegistration, for: indexPath, item: itemIdentifier)
            case 2: // Tip
                collectionView.dequeueConfiguredReusableCell(using: tipCellRegistration, for: indexPath, item: itemIdentifier)
            default:
                collectionView.dequeueConfiguredReusableCell(using: tipCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
    }
    
}

