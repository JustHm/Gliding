//
//  ViewController+CollectionViewLayout.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit



extension ViewController {
    // Section
    enum HomeSection: Hashable, CaseIterable{
        case today
        case poolInfo
        case tip
        
        var header: String {
            switch self {
            case .today:
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
        case today(StatisticData?) //single card
        case pool(PoolInfo) // horizontal scroll
        case tip(ArticleModel) // like banner
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
            return NSCollectionLayoutSection.WideBannerSection(headerElementKind: HomeHeader.elementKind)
        case 1: // pool
            return NSCollectionLayoutSection.CardViewHorizontalScrollingSection(headerElementKind: HomeHeader.elementKind)
        case 2: // swim tip
            return NSCollectionLayoutSection.ListStyleHorizontalScrollingSection(headerElementKind: HomeHeader.elementKind)
        default:
            return NSCollectionLayoutSection.WideBannerSection(headerElementKind: HomeHeader.elementKind) // 임시
        }
    }
}
