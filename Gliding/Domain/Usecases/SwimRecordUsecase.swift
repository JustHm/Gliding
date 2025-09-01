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
    func fetchSwimRecordByDay(date: Date) async throws -> DaySwimRecord
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
            records.append(SwimmingRecordList(swimmingLocationType: location, duration: workout.duration, workoutDates: startDate))
        }
        return records
    }
    
    func fetchSwimRecordByDay(date: Date) async throws -> DaySwimRecord {
        var result = DaySwimRecord()
        let startDate = date.startOfDay()
        let endDate = date.endOfDay()!
        
        let distanceResult = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: startDate, end: endDate)
        let strokeResult = try await repository.fetchDataByDateRange(type: .swimmingStrokeCount, start: startDate, end: endDate)

        let startActivityDate = [distanceResult.first?.startDate, strokeResult.first?.startDate].compactMap{$0}.max() ?? startDate
        let endActivityDate = [distanceResult.last?.endDate, strokeResult.last?.endDate].compactMap{$0}.max() ?? endDate
        
        result.totalActivityBurn = try await repository.fetchStatisticsQuery(type: .activeEnergyBurned, unit: .kilocalorie(), start: startActivityDate, end: endActivityDate, option: .cumulativeSum)
        // 여기서 hearRate도 fetch
        
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

