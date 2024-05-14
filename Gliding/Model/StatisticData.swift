//
//  StatisticData.swift
//  Gliding
//
//  Created by 안정흠 on 3/14/24.
//

import UIKit

struct StatisticData: Hashable {
    var workoutDone: Bool
}

struct TrainingMenuData: Hashable {
    var name: String
    var description: String
    var color: UIColor
}

struct PoolInfo: Hashable {
    var id: String
    var name: String
    var image: UIImage
    var locate: String
}
