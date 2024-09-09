//
//  ViewController+CollectionViewLayout.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit
// Section
enum HomeSection: Int, Hashable{
    case mainStatistic
//    case shareMenu    //trainning table share list
    case poolInfo
    case tip
    
    var header: String {
        switch self {
        case .mainStatistic:
            return "오늘 운동"
        case .poolInfo:
            return "내 근처의 수영장"
        case .tip:
            return "수영 팁"
        }
    }
}

// Item
enum HomeSectionItem: Hashable {
    case statistic(StatisticData?) //single card
//    case trainingMenu(TrainingTableModel)
    case pool(PoolInfo?) // horizontal scroll
    case tip // like banner
}

extension ViewController {
    public func makeCollectionView() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex,_) -> NSCollectionLayoutSection? in
            return self.createSection(for: sectionIndex)
        }
        return layout
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0: // main
            return createMainSection()
        case 1: // pool
            return createHorizontalScrollingSection()
        case 2: // swim tip
            return createHorizontalScrollingSection()
        default:
            return createMainSection() // 임시
        }
    }
    
    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func createHorizontalScrollingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(300)) //heightDimension: .fractionalHeight(0.3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
