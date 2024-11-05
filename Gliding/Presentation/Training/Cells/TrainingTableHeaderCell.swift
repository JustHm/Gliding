//
//  TrainingTableHeaderCell.swift
//  Gliding
//
//  Created by 안정흠 on 9/26/24.
//

import UIKit

final class TrainingTableHeaderCell: UICollectionViewCell {
    lazy var titleField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 16, weight: .medium)
        field.isUserInteractionEnabled = false
        return field
    }()
    lazy var descriptionField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 14, weight: .medium)
        field.isUserInteractionEnabled = false
        return field
    }()
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    func configure(title: String, description: String, isEdit: Bool = false) {
        titleField.text = title
        descriptionField.text = description
        titleField.isUserInteractionEnabled = isEdit
        descriptionField.isUserInteractionEnabled = isEdit
        setupLayout()
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleField, seperatorView, descriptionField])
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        seperatorView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
