//
//  HomeHeader.swift
//  Gliding
//
//  Created by 안정흠 on 9/13/24.
//

import UIKit

final class HomeHeader: UICollectionReusableView {
    static let elementKind = "section-header-element-kind"
    lazy var header: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .headline)
        return textField
    }()
    
    func configure(text: String) {
        header.text = text
    }
    
    private func setupLayout() {
        addSubview(header)
        header.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
    }
}
