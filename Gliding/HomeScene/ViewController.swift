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
        let mainCellRegistration = UICollectionView.CellRegistration<MainProfileCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
//            cell.configure()
        }
        let poolCellRegistration = UICollectionView.CellRegistration<PoolInfoCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
//            cell.configure()
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        })
    }


}

