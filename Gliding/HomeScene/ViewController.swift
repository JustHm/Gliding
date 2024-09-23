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
import RxCocoa

class ViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>
    var dataSource: DataSource!
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionView())
        collection.delegate = self
//        collection.backgroundColor = .gray
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
            .bind(onNext: { _ in
                refreshLoading.accept(true)
            }).disposed(by: disposeBag)
        
        let input = HomeViewModel.Input(refresh: refreshLoading)
        let output = viewModel.transform(input: input)
        
        Driver.combineLatest(output.today, output.poolList, output.swimTip)
            .drive { [weak self] today, poolList, tips in
                self?.fetchCollectionViewData(today: today, poolList: poolList, tips: tips)
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        navigationController?.navigationBar.backgroundColor = .green
//        navigationController?.navigationBar.inputView
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    private func fetchCollectionViewData(today: StatisticData?, poolList: [PoolInfo], tips: [ArticleModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSectionItem>()
        snapshot.appendSections(HomeSection.allCases)
        snapshot.appendItems([HomeSectionItem.today(today)], toSection: .today)
        snapshot.appendItems(poolList.map{HomeSectionItem.pool($0)}, toSection: .poolInfo)
        snapshot.appendItems(tips.map{HomeSectionItem.tip($0)}, toSection: .tip)
        dataSource.apply(snapshot,animatingDifferences: true)
        
    }
    
    private func configureCollectionView() {
        let mainCellRegistration = UICollectionView.CellRegistration<MainProfileCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
            if case let HomeSectionItem.today(data) = itemIdentifier {
                cell.configure(data: data)
            }
        }
        let poolCellRegistration = UICollectionView.CellRegistration<PoolInfoCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
            if case let HomeSectionItem.pool(data) = itemIdentifier {
                cell.configure(poolInfo: data)
            }
        }
        let tipCellRegistration = UICollectionView.CellRegistration<SwimTipCell,HomeSectionItem> {cell,indexPath,itemIdentifier in
            if case let HomeSectionItem.tip(data) = itemIdentifier {
                cell.configure(title: data.title )
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<HomeHeader>(elementKind: HomeHeader.elementKind, handler: { supplementaryView,elementKind,indexPath in
            let headerText = HomeSection.allCases[indexPath.section].header
            supplementaryView.configure(text: headerText)
        })
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch indexPath.section {
            case 0: // Main Statistic (Simple)
                collectionView.dequeueConfiguredReusableCell(using: mainCellRegistration, for: indexPath, item: itemIdentifier)
            case 1: // PoolInfo
                collectionView.dequeueConfiguredReusableCell(using: poolCellRegistration, for: indexPath, item: itemIdentifier)
            case 2: // Tip
                collectionView.dequeueConfiguredReusableCell(using: tipCellRegistration, for: indexPath, item: itemIdentifier)
            default:
                collectionView.dequeueConfiguredReusableCell(using: mainCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == HomeHeader.elementKind else { return UICollectionReusableView() }
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        refreshControl.endRefreshing()
        collectionView.refreshControl = refreshControl
        collectionView.dataSource = dataSource
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .today(let data): // move to statistics Tab
            print("today Cell \(String(describing: data))")
            break;
        case .pool(let data): // move to PoolDetail View
            print("pool Cell \(String(describing: data))")
            break;
        case .tip(let data): // move to Tip Article View
            print("tip Cell \(String(describing: title))")
            break;
        }
    }
}
