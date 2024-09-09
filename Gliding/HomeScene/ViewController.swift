//
//  ViewController.swift
//  Gliding
//
//  Created by 안정흠 on 3/4/24.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>
    var dataSource: DataSource?
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionView())
        collection.delegate = self
        collection.backgroundColor = .green
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = HomeViewModel()
        
        setupLayout()
        configureCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let refreshObservable = collectionView.refreshControl?.rx.controlEvent(.valueChanged)
            .map { [weak self] in
                self?.collectionView.refreshControl?.isRefreshing ?? false
            }
            .asObservable() ?? Observable.just(false)
        
        let input = HomeViewModel.Input(refresh: refreshObservable)
        
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func fetchCollectionViewData(data: [HomeSectionItem], section: HomeSection) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSectionItem>()
        snapshot.appendSections([section])
        snapshot.appendItems(data, toSection: section)
        dataSource?.apply(snapshot)
    }
    
    private func configureCollectionView() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HomeSectionItem> {cell,indexPath,itemIdentifier in
            switch itemIdentifier {
            case .pool(let data):
                if let poolCell = cell as? PoolInfoCell {
                    poolCell.configure(poolInfo: data)
                }
            case .statistic(let data):
                if let statisticCell = cell as? MainProfileCell {
                    statisticCell.configure(data: data)
                }
            case .tip:
                if let tipCell = cell as? SwimTipCell {
                    tipCell.configure(title: "data")
                }
            }
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch indexPath.section {
            case 0: // Main Statistic (Simple)
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            case 1: // PoolInfo
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            case 2: // Tip
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            default:
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
        //        collectionView.refreshControl
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .statistic(let data): // move to statistics Tab
            break;
        case .pool(let data): // move to PoolDetail View
            break;
        case .tip: // move to Tip Article View
            break;
        }
    }
}
