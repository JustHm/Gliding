//
//  SwimTipCell.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit

class SwimTipCell: UICollectionViewCell {
    static let identifier = String(describing: SwimTipCell.self)
    
    public func configure(title: String) {
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .cyan
    }
}
