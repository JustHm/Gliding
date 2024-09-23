//
//  MainProfileCell.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit

class MainProfileCell: UICollectionViewCell {
    static let identifier = String(describing: MainProfileCell.self)
    private let cornerRadius: CGFloat = 14
    var isWorkoutToday: Bool = false
    var distance: Int = 0
    var calories: Int = 0
    
    public func configure(data: StatisticData?) {
        setupLayout()
        
    }
    
    private func setupLayout() {
        configureProperty()
    }
    
    private func configureProperty() {
        //corner
        contentView.layer.cornerRadius = cornerRadius
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        //shadow
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        
    }
}
