//
//  TrainingListViewController.swift
//  Gliding
//
//  Created by 안정흠 on 9/23/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class TrainingListViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, TrainingTableModel>
    
    private var dataSource: DataSource!
    private let disposeBag = DisposeBag()
    private var viewModel: TrainingListViewModel!
    
    private let deleteItem = PublishRelay<UUID>()
    private let searchQuery = PublishRelay<String>()
    
    lazy var collectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = true
        config.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewCompositionalLayout.list(using: config))
        collectionView.delegate = self
        return collectionView
    }()
    lazy var addButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: nil)
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init()
        setupLayout()
        setupCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = TrainingListViewModel.Input(deleted: deleteItem,
                                                searchFromTitle: searchQuery
        )
        let output = viewModel.transform(input: input)
        output.trainingList
            .drive { [weak self] data in
                self?.fetchCollectionViewData(data: data)
            }
            .disposed(by: disposeBag)
    }
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        title = "Training List"
        navigationItem.rightBarButtonItem = addButton
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func fetchCollectionViewData(data: [TrainingTableModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, TrainingTableModel>()
        snapShot.appendSections([0])
        snapShot.appendItems(data)
        dataSource.apply(snapShot)
    }
    private func setupCollectionView() {
        let cellRegister = UICollectionView.CellRegistration<UICollectionViewListCell, TrainingTableModel> { cell, indexPath, data in
            var config = cell.defaultContentConfiguration()
            config.text = data.title
            config.secondaryText = data.detail
//            config.prefersSideBySideTextAndSecondaryText = true
            config.textToSecondaryTextVerticalPadding = 10
            cell.accessories = [
                .disclosureIndicator(displayed: .whenNotEditing),
                .delete(displayed: .whenEditing)
            ]
            cell.contentConfiguration = config
        }
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, data in
            collectionView.dequeueConfiguredReusableCell(using: cellRegister, for: indexPath, item: data)
        }
        
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let item = dataSource.itemIdentifier(for: indexPath) else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.deleteItem.accept(item.id)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension TrainingListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let vc = TrainingDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
