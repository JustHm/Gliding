//
//  TrainingDetailViewController.swift
//  Gliding
//
//  Created by 안정흠 on 9/26/24.
//

import UIKit


final class TrainingDetailViewController: UIViewController {
    private var dataSource: DataSource!
    private var viewModel: TrainingDetailViewModel!
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionView())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TrainingDetailViewModel()
        setupLayout()
        setupCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        let trainingSetCellRegistration = UICollectionView.CellRegistration<TrainingSetCell, Item> { cell, indexPath, itemIdentifier in
            if case let Item.trainingSet(data, isEditing) = itemIdentifier {
                cell.configure(title: data.title, lane: data.lane, rep: data.rep, time: data.timeLimit)
            }
        }
        let headerCellRegistration = UICollectionView.CellRegistration<TrainingTableHeaderCell, Item> { cell, indexPath, itemIdentifier in
            if case let Item.header(data, isEditing) = itemIdentifier {
                cell.configure(title: data.title, description: data.detail, isEdit: isEditing)
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<TrainingSetHeader>(elementKind: TrainingSetHeader.elementKind) { header, kind, indexPath in
            let headerText = Section.allCases[indexPath.section].header
            header.configure(text: headerText)
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let section = Section.allCases[indexPath.section]
            switch section {
            case .header:
                return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: item)
            case .warmUp, .mainSet, .coolDown:
                return collectionView.dequeueConfiguredReusableCell(using: trainingSetCellRegistration, for: indexPath, item: item)
            }
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == TrainingSetHeader.elementKind else { return UICollectionReusableView() }
            let section = Section.allCases[indexPath.section]
            switch section {
            case .header:
                return UICollectionReusableView()
            case .warmUp, .mainSet, .coolDown:
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            }
        }
    }
    
    
}

extension TrainingDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Item>
    enum Section: Hashable, CaseIterable {
        case header
        case warmUp
        case mainSet
        case coolDown
        
        var header: String {
            switch self {
            case .header:
                return ""
            case .warmUp:
                return "Warm Up"
            case .mainSet:
                return "Main"
            case .coolDown:
                return "Cool Down"
            }
        }
    }
    enum Item: Hashable {
        case header(TrainingTableDisplayModel, Bool)
        case trainingSet(TrainingSetModel, Bool)
    }
    
    func makeCollectionView() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            return self.createSection(for: sectionIndex)
        }
        return layout
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0:
            return NSCollectionLayoutSection.WideBannerSection(headerElementKind: nil)
        case 1,2,3:
            return NSCollectionLayoutSection.CardViewHorizontalScrollingSection(
                groupSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)),
                headerElementKind: TrainingSetHeader.elementKind
            )
        default:
            return NSCollectionLayoutSection.WideBannerSection(headerElementKind: nil)
        }
    }
}
