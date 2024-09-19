//
//  MainProfileCell.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit

class MainProfileCell: UICollectionViewCell {
    static let identifier = String(describing: MainProfileCell.self)
    var isWorkoutToday: Bool = false
    var distance: Int = 0
    var calories: Int = 0
    
    public func configure(data: StatisticData?) {
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .cyan
        contentView.layer.cornerRadius = 10
    }
}
