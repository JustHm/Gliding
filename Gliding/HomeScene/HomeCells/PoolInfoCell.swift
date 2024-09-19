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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        contentView.backgroundColor = .cyan
        contentView.layer.cornerRadius = 10
        contentView.addSubview(nameField)
        
        nameField.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(18.0)
            $0.top.equalToSuperview().offset(8.0)
        }
    }
}
