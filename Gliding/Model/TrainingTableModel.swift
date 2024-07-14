//
//  TrainingTableModel.swift
//  Gliding
//
//  Created by 안정흠 on 3/5/24.
//

import Foundation

struct TrainingTableModel {
    var title: String
    var description: String
    var warmUpSet: [TrainingAsset]
    var mainSet: [TrainingAsset]
    var coolDownSet: [TrainingAsset]
}

struct TrainingAsset {
    var name: String
    var lane: Int //lane distance 25,50,100...
    var rep: Int // loop
    var timeLimit: Int
    var effort: Int // %
}
