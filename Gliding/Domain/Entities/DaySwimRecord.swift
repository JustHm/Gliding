//
//  DaySwimRecord.swift
//  Gliding
//
//  Created by 안정흠 on 7/26/25.
//

import Foundation

struct DaySwimRecord {
    // 요약
    var totalDistance: Double
    var totalTime: Double
    var totalActivityBurn: Double
    // 영법별 수행 거리
    var freeStyleDistance: Double
    var backstrokeDistance: Double
    var breaststrokeDistance: Double
    var butterflyDistance: Double
    var kickboardDistance: Double
    var mixedDistance: Double
    var unknownDistance: Double
    //그 외
    var sourceRevision: String? // 기록한 기기 이름
    
    init(totalDistance: Double = 0,
         totalTime: Double = 0,
         totalActivityBurn: Double = 0,
         freeStyleDistance: Double = 0,
         backstrokeDistance: Double = 0,
         breaststrokeDistance: Double = 0,
         butterflyDistance: Double = 0,
         kickboardDistance: Double = 0,
         mixedDistance: Double = 0,
         unknownDistance: Double = 0,
         sourceRevision: String? = nil
    ) {
        self.totalDistance = totalDistance
        self.totalTime = totalTime
        self.totalActivityBurn = totalActivityBurn
        self.freeStyleDistance = freeStyleDistance
        self.backstrokeDistance = backstrokeDistance
        self.breaststrokeDistance = breaststrokeDistance
        self.butterflyDistance = butterflyDistance
        self.kickboardDistance = kickboardDistance
        self.mixedDistance = mixedDistance
        self.unknownDistance = unknownDistance
        self.sourceRevision = sourceRevision
    }
}
