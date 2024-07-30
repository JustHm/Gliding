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
    var category: [TrainCategory] // 중복 선택 가능
    // Training Assets
    var warmUpSet: [TrainingAsset]
    var mainSet: [TrainingAsset]
    var coolDownSet: [TrainingAsset]
}

struct TrainingAsset {
    var name: String
    var lane: Int //lane distance 25,50,100...
    var rep: Int // loop
    var timeLimit: Int?
    var effort: Int? // low middle high
}

enum TrainCategory: Int {
    case freestyle = 10 // 자유형
    case backstroke = 20 // 배영
    case breaststroke = 30 // 평영
    case butterfly = 40 //접영
    case any = 90
}
