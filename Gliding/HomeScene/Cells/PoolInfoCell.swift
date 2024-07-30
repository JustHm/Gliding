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
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(address: String, name: String, phone: String, website: String) {
        self.address = address
        self.name = name
        self.phone = phone
        self.website = website
    }
    private func setupLayout() {
        contentView.addSubview(nameField)
        
        nameField.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(18.0)
            $0.top.equalToSuperview().offset(8.0)
        }
    }
}
