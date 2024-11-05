//
//  TrainingSetCell.swift
//  Gliding
//
//  Created by 안정흠 on 9/26/24.
//

import UIKit

final class TrainingSetCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    lazy var laneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    func configure(title: String = "", lane: Int?, rep: Int?, time: Int? = nil) {
        titleLabel.text = title
        
        if let lane, let rep {
            laneLabel.text = "\(lane)M X \(rep)"
        }
        else { laneLabel.isHidden = true }
        
        if let time {
            let minutes = time / 60
            let seconds = time % 60
            timeLabel.text = "\(minutes):\(seconds)"
        }
        else { timeLabel.isHidden = true }
        
        setupLaytout()
    }
    
    private func setupLaytout() {
        var stackView = UIStackView(arrangedSubviews: [laneLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        [titleLabel, stackView].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(8)
        }
        stackView.snp.makeConstraints {
            $0.bottom.right.equalToSuperview().inset(8)
        }
    }
}
