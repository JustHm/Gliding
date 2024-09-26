//
//  TrainingTableModel.swift
//  Gliding
//
//  Created by 안정흠 on 3/5/24.
//

import Foundation

struct TrainingTableModel: Hashable {
    var id: UUID
    var title: String
    var detail: String
    // Training Assets
    var warmUpSet: [TrainingSetModel]
    var mainSet: [TrainingSetModel]
    var coolDownSet: [TrainingSetModel]
    
    init(id: UUID = UUID(), title: String, detail: String, warmUpSet: [TrainingSetModel], mainSet: [TrainingSetModel], coolDownSet: [TrainingSetModel]) {
        self.id = id
        self.title = title
        self.detail = detail
        self.warmUpSet = warmUpSet
        self.mainSet = mainSet
        self.coolDownSet = coolDownSet
    }
    
}

struct TrainingSetModel: Hashable {
    var id: UUID
    var name: String
    var detial: String
    var lane: Int //lane distance 25,50,100...
    var rep: Int // loop
    var timeLimit: Int?
}
