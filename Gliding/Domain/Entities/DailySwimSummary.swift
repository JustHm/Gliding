//
//  DailySwimSummary.swift
//  Gliding
//
//  Created by 안정흠 on 7/26/25.
//

import Foundation

struct DailySwimSummary {
    // 요약
    var totalDistance: Double
    var totalTime: Double
    var startDate: Date
    var endDate: Date
    // 영법별 수행 거리
    var distanceOfStyle: [StrokeType: Double]
    //그 외
    var sourceRevision: String // 기록한 기기 이름
    
    init(totalDistance: Double = 0,
         totalTime: Double = 0,
         startDate: Date = Date(),
         endDate: Date = Date(),
         distanceOfStyle: [StrokeType: Double] = [StrokeType: Double](),
         sourceRevision: String = ""
    ) {
        self.totalDistance = totalDistance
        self.totalTime = totalTime
        self.startDate = startDate
        self.endDate = endDate
        self.distanceOfStyle = distanceOfStyle
        self.sourceRevision = sourceRevision
    }
}

struct DailyStatusSummary {
    var totalActivityBurn: Double
    var heartRateBucket: [HeartRateRangeBucket]
    var heartRateMax: Double
    var heartRateAvg: Double
    
    init(
        totalActivityBurn: Double = 0.0,
        heartRateBucket: [HeartRateRangeBucket] = [],
        heartRateMax: Double = 0.0,
        heartRateAvg: Double = 0.0
    ) {
        self.totalActivityBurn = totalActivityBurn
        self.heartRateBucket = heartRateBucket
        self.heartRateMax = heartRateMax
        self.heartRateAvg = heartRateAvg
    }
}
struct HeartRateRangeBucket: Identifiable {
    var id: Date { start }
    let start: Date
    let end: Date
    let minBPM: Double
    let maxBPM: Double
    let avgBPM: Double?
}
