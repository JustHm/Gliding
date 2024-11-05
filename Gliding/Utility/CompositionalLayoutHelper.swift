//
//  CompositionalLayoutHelper.swift
//  Gliding
//
//  Created by 안정흠 on 9/26/24.
//

import UIKit

extension NSCollectionLayoutSection {
    static func ListStyleHorizontalScrollingSection(
        itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
        groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.8/2), heightDimension: .estimated(50)),
        sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16),
        headerElementKind: String?,
        repeatCount: Int = 5
    ) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: repeatCount)
        let section = NSCollectionLayoutSection(group: group)
        //        group.interItemSpacing = .fixed(1)
        
        section.interGroupSpacing = 10
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .groupPagingCentered
        if let headerElementKind {
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                                                            elementKind: headerElementKind,
                                                            alignment: .topLeading)
            ]
        }
        return section
    }
    
    static func CardViewHorizontalScrollingSection(
        itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
        groupSize: NSCollectionLayoutSize =  NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(200)),
        sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16),
        headerElementKind: String?
    ) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .continuous
        if let headerElementKind {
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                                                            elementKind: headerElementKind,
                                                            alignment: .topLeading)
            ]
        }
        return section
    }
    
    static func WideBannerSection(
        itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
        groupSize: NSCollectionLayoutSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)),
        sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16),
        headerElementKind: String?
    ) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = sectionInset
        section.orthogonalScrollingBehavior = .none
        if let headerElementKind {
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                                                            elementKind: headerElementKind,
                                                            alignment: .topLeading),
            ]
        }
        
        return section
    }
}
