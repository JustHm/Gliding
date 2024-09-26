//
//  CompositionalLayoutHelper.swift
//  Gliding
//
//  Created by 안정흠 on 9/26/24.
//

import UIKit

struct CompositionalLayoutHelper {
    enum LayoutViewType {
        case SingleItem(width: CGFloat, height: CGFloat, withoutHeader: Bool = false)
        case horizontalCardScroll(width: CGFloat, height: CGFloat, withoutHeader: Bool = false)
        case horizontalListScroll(width: CGFloat, height: CGFloat, limit: Int, withoutHeader: Bool = false)
    }
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
            return createListHorizontalScrollingSection()
        default:
            return createMainSection() // 임시
        }
    }

    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                                                        elementKind: HomeHeader.elementKind,
                                                        alignment: .topLeading)
        ]
        return section
    }

    private func createHorizontalScrollingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(200)) //heightDimension: .fractionalHeight(0.3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                                                        elementKind: HomeHeader.elementKind,
                                                        alignment: .topLeading)
        ]
        return section
    }

    private func createListHorizontalScrollingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.8/2), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 5)
        group.interItemSpacing = .fixed(1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                                                        elementKind: HomeHeader.elementKind,
                                                        alignment: .topLeading)
        ]
        return section
    }

}

