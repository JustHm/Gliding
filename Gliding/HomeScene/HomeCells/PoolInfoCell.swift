//
//  PoolInfoCell.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//
import SwiftUI
import UIKit
import MapKit
import SnapKit

class PoolInfoCell: UICollectionViewCell {
    static let identifier = String(describing: PoolInfoCell.self)
    private let cornerRadius: CGFloat = 14
    var address: String?
    var name: String?
    var phone: String?
    var website: String?
    
    lazy var nameField: UITextField = {
        let field = UITextField()
        field.text = "NAME"
        field.font = .preferredFont(forTextStyle: .title1)
        return field
    }()
    
    public func configure(poolInfo: PoolInfo?) {
        if let poolInfo {
            self.address = poolInfo.address
            self.name = poolInfo.name
            self.phone = poolInfo.phone
            self.website = poolInfo.website
        }
        setupLayout()
    }
    private func setupLayout() {
        configureProperty()
        contentView.addSubview(nameField)
        
        nameField.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(18.0)
            $0.top.equalToSuperview().offset(8.0)
        }
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
