//
//  TrainingTableModel.swift
//  Gliding
//
//  Created by 안정흠 on 3/5/24.
//

import Foundation

struct TrainingTableModel: Hashable, Codable {
    var id: UUID
    var title: String
    var detail: String
    // Training Assets
    var warmUpSet: [TrainingSetModel]
    var mainSet: [TrainingSetModel]
    var coolDownSet: [TrainingSetModel]
}

struct TrainingSetModel: Hashable, Codable{
    var id: UUID
    var title: String
    var lane: Int //lane distance 25,50,100...
    var rep: Int // loop
    var timeLimit: Int?
}


struct TrainingTableDisplayModel: Hashable {
    var id: UUID
    var title: String
    var detail: String
}

struct TrainingSetListModel: Hashable {
    var warmUpSet: [TrainingSetModel]
    var mainSet: [TrainingSetModel]
    var coolDownSet: [TrainingSetModel]
}
