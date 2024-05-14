//
//  ViewController+CollectionViewLayout.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit
// Section
enum HomeSection: Int {
    case mainStatistic
    case trainningMenu
    case shareMenu
    case poolInfo
}

// Item
enum HomeSectionItem {
    case statistic(StatisticData)
    case trainingMenu(TrainingMenuData)
    case pool(PoolInfo)
}

extension ViewController {
    private func makeCollectionView() {
          let layout = UICollectionViewCompositionalLayout { (sectionIndex,_) -> NSCollectionLayoutSection? in
            return self.createSection(for: sectionIndex)
        }
    }

    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
            case 0:
                return createTwoColumnSection(weightConstant: sectionIndex)
            case 1:
                return createSingleColumnSection()
            case 2:
                return createTwoColumnSection(weightConstant: sectionIndex)
            case 3:
                return createHorizontalScrollingSection()
            default:
                return createSingleColumnSection() // 임시로 넣어놨다. 섹션은 0~3까지고, 여기 도달할 일없지만, 만약 도달하면 error니까 제대로 된 error 처리 요망
        }
    }
    
    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        return section
    }
    
    private func createMenuSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createPoolSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    private func createTwoColumnSection(weightConstant :Int) -> NSCollectionLayoutSection {
            let weight = (Double(weightConstant) * 0.05)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(0.98))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1 + weight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = NSCollectionLayoutSpacing.flexible(10.0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 15.0
            
            return section
        }
        
        private func createSingleColumnSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.7))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        private func createHorizontalScrollingSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
}
