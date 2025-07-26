//
//  SwimRecord.swift
//  Gliding
//
//  Created by 안정흠 on 7/26/25.
//

import Foundation

struct SwimRecord {
    // 요약
    let totalDistance: Double
    let totalTime: Double
    let activityBurn: Double
    // 영법별 수행 거리
    let freeStyleDistance: Double
    let backstrokeDistance: Double
    let breaststrokeDistance: Double
    let butterflyDistance: Double
    //그 외
    let sourceRevision: String? // 기록한 기기 이름
}
