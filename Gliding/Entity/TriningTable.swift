//
//  TriningTable.swift
//  Gliding
//
//  Created by 안정흠 on 9/25/24.
//
import Foundation
import SwiftData

@Model
class TrainingTableEntity {
    @Attribute(.unique) var id: UUID
    var title: String
    var detail: String
    var totalLength: Int
    var date: Date
    // Training Set
    var warmup: String
    var mainset: String
    var cooldown: String
    
    init(id: UUID, title: String, detail: String, totalLength: Int, date: Date, warmup: String, mainset: String, cooldown: String) {
        self.id = id
        self.title = title
        self.detail = detail
        self.totalLength = totalLength
        self.date = date
        self.warmup = warmup
        self.mainset = mainset
        self.cooldown = cooldown
    }
}
