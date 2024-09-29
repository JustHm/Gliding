//
//  HomeHeader.swift
//  Gliding
//
//  Created by 안정흠 on 9/13/24.
//

import UIKit

final class HomeHeader: UICollectionReusableView {
    static let elementKind = UICollectionView.elementKindSectionHeader
    static let identifier = "home-header"
    lazy var header: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.font = .preferredFont(forTextStyle: .extraLargeTitle2)
        return textField
    }()
    
    func configure(text: String) {
        header.text = text
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(header)
        header.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
    }
}
