//
//  SwimRecordUsecase.swift
//  Gliding
//
//  Created by 안정흠 on 7/26/25.
//

import Foundation
import HealthKit
import CoreLocation

protocol SwimRecordUsecase {
    ///한 달간의 수영기록을 불러옴
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> [SwimmingRecordList]
    ///하루의 수영기록 상세정보를 불러옴
    func fetchSwimRecordByDay(date: Date) async throws -> DailySwimSummary
    ///하루의 운동기록 중 심장박동, 칼로리를 반환
    func fetchDailyStatusFromWorkout(start: Date, end: Date, interval: DateComponents) async throws -> DailyStatusSummary
    ///하루의 수영기록이  OpenWater일때 Route를 반환함
    func fetchSwimmingRouteFromOpenWater(date: Date) async throws -> [CLLocationCoordinate2D]
    ///HealthKit 권한 체크
    func requestAuthorization() async throws -> Bool
}

final class SwimRecordUsecaseImpl: SwimRecordUsecase {
    let repository: HealthKitRecordRepository
    
    init(repository: HealthKitRecordRepository) {
        self.repository = repository
    }
    
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> [SwimmingRecordList] {
        var records = [SwimmingRecordList]()
        let workouts = try await repository.fetchWorkoutSwimmingType(start: start, end: end)
        
        for workout in workouts {
            let locationRawvalue = workout.metadata?[HKMetadataKeySwimmingLocationType] as? Int ?? 0
            let location = SwimmingLocationType(rawValue: locationRawvalue) ?? .unknown
            
            let startDate = workout.startDate.startOfDay()
            records.append(SwimmingRecordList(swimmingLocationType: location, duration: workout.duration, workoutDate: startDate))
        }
        return records
    }
    
    func fetchSwimRecordByDay(date: Date) async throws -> DailySwimSummary {
        var result = DailySwimSummary()
        let startDate = date.startOfDay()
        let endDate = date.endOfDay()!
        
        let distanceResult = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: startDate, end: endDate)
        let strokeResult = try await repository.fetchDataByDateRange(type: .swimmingStrokeCount, start: startDate, end: endDate)
        
        result.startDate = [distanceResult.first?.startDate, strokeResult.first?.startDate].compactMap{$0}.max() ?? startDate
        result.endDate = [distanceResult.last?.endDate, strokeResult.last?.endDate].compactMap{$0}.max() ?? endDate
        result.sourceRevision = strokeResult.first?.sourceRevision.source.name ?? "Unknown device"
        
        // SwimRecordSummary
        var distanceIndex = 0
        var strokeIndex = 0
        
        while distanceIndex < distanceResult.count && strokeIndex < strokeResult.count {
            let distance = distanceResult[distanceIndex].quantity.doubleValue(for: .meter())
            let distanceStartDate = distanceResult[distanceIndex].startDate
            let strokeStartDate = strokeResult[strokeIndex].startDate
            var strokeType: StrokeType?
            
            if distanceStartDate == strokeStartDate,
               let type = strokeResult[strokeIndex].metadata?[HKMetadataKeySwimmingStrokeStyle] as? Int
            {
                strokeType = StrokeType(rawValue: type)
            }
            else { strokeIndex -= 1 }
            
            result.totalDistance += distance
            result.distanceOfStyle[strokeType ?? .typeUnknown, default: 0] += distance
            
            
            strokeIndex += 1
            distanceIndex += 1
        }
        
        return result
    }
    
    func fetchDailyStatusFromWorkout(start: Date, end: Date, interval: DateComponents) async throws -> DailyStatusSummary {
        var result = DailyStatusSummary()
        result.totalActivityBurn = try await repository.fetchStatisticsQuery(type: .activeEnergyBurned, unit: .kilocalorie(), start: start, end: end, options: .cumulativeSum)
        
        
        
        
        // HeartRate Summary
        let heartRateCollection = try await repository.fetchStatisticsCollectionQuery(
            type: .heartRate,
            start: start,
            end: end,
            options: [.discreteMin, .discreteMax, .discreteAverage],
            interval: interval
        )
        
        let bpmUnit = HKUnit.count().unitDivided(by: .minute())
        
        result.heartRateMax = try await repository.fetchStatisticsQuery(type: .heartRate, unit: bpmUnit, start: start, end: end, options: .discreteMax)
        result.heartRateAvg = try await repository.fetchStatisticsQuery(type: .heartRate, unit: bpmUnit, start: start, end: end, options: .discreteAverage)
        
        
        heartRateCollection.enumerateStatistics(from: start, to: end) { stats, _ in
            guard let minQ = stats.minimumQuantity(),
                  let maxQ = stats.maximumQuantity() else { return }
            let min = minQ.doubleValue(for: bpmUnit)
            let max = maxQ.doubleValue(for: bpmUnit)
            let avg = stats.averageQuantity()?.doubleValue(for: bpmUnit)
            result.heartRateBucket.append(.init(start: stats.startDate, end: stats.endDate, minBPM: min, maxBPM: max, avgBPM: avg))
        }
        return result
    }
    
    func fetchSwimmingRouteFromOpenWater(date: Date) async throws -> [CLLocationCoordinate2D] {
        //        var routes = [[CLLocationCoordinate2D]]()
        //        for workout in try await repository.fetchWorkoutSwimmingType(start: date.startOfDay(), end: date.endOfDay()!) {
        //            routes.append(contentsOf: try await repository.fetchOpenWaterRoute(workout: workout))
        //
        //        }
        ////
        return []
    }
    
    func requestAuthorization() async throws -> Bool {
        try await repository.requestAuthorization()
    }
}

