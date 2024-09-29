//
//  SwimTipCell.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit

class SwimTipCell: UICollectionViewCell {
    static let identifier = String(describing: SwimTipCell.self)
    private let cornerRadius: CGFloat = 0
    lazy var seperatorView: UIView = {
        let seperatorView = UIView()
        seperatorView.backgroundColor = .separator
        return seperatorView
    }()
    
    public func configure(title: String) {
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(seperatorView)
        seperatorView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
