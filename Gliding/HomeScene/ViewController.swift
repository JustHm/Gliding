//
//  ViewController.swift
//  Gliding
//
//  Created by 안정흠 on 3/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

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
        let refreshLoading = PublishRelay<Bool>()
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(onNext: { [weak self] _ in
                // 아래코드: viewModel에서 발생한다고 가정
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) { [weak self] in
                    refreshLoading.accept(true)
                }
            }).disposed(by: disposeBag)
        
        let input = HomeViewModel.Input(refresh: refreshLoading)
        let output = viewModel.transform(input: input)
        
        output.today
            .drive(onNext: { [weak self] data in
                let data = HomeSectionItem.statistic(data)
                self?.fetchCollectionViewData(data: [data], section: .mainStatistic)
            })
            .disposed(by: disposeBag)
        
        output.poolList
            .map {$0.compactMap{HomeSectionItem.pool($0)}}
            .drive { [weak self] data in
                self?.fetchCollectionViewData(data: data, section: .poolInfo)
            }
            .disposed(by: disposeBag)
        
        output.swimTip
            .map {$0.compactMap{HomeSectionItem.tip($0)}}
            .drive { [weak self] data in
                self?.fetchCollectionViewData(data: data, section: .poolInfo)
            }
            .disposed(by: disposeBag)
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
        refreshControl.endRefreshing()
        collectionView.refreshControl = refreshControl
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
