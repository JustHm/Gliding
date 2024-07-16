//
//  PoolInfoCell.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit

class PoolInfoCell: UICollectionViewCell {
    static let identifier = String(describing: PoolInfoCell.self)
    var address: String?
    var name: String?
    var phone: String?
    var website: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
}

