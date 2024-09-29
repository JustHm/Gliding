//
//  TrainingDetailViewController.swift
//  Gliding
//
//  Created by 안정흠 on 9/26/24.
//

import UIKit

final class TrainingDetailViewController: UIViewController {
    private var viewModel: TrainingDetailViewModel!
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TrainingDetailViewModel()
        setupLayout()
        setupCollectionView()
        bindViewModel()
    }
    
    private func setupLayout() {
        
    }
    
    private func setupCollectionView() {
        
    }
    
    private func bindViewModel() {
        
    }
}
