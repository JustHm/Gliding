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
    var distanceOfStyle: [StrokeType: Double]
    //그 외
    var sourceRevision: String? // 기록한 기기 이름
    
    init(totalDistance: Double = 0,
         totalTime: Double = 0,
         totalActivityBurn: Double = 0,
         distanceOfStyle: [StrokeType: Double] = [StrokeType: Double](),
         sourceRevision: String? = nil
    ) {
        self.totalDistance = totalDistance
        self.totalTime = totalTime
        self.totalActivityBurn = totalActivityBurn
        self.distanceOfStyle = distanceOfStyle
        self.sourceRevision = sourceRevision
    }
}
