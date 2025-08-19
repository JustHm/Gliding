//
//  SwimRecordUsecase.swift
//  Gliding
//
//  Created by 안정흠 on 7/26/25.
//

import Foundation
import HealthKit

protocol SwimRecordUsecase {
    ///한 달간의 수영기록을 불러옴
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> [SwimmingRecordList]
    ///하루의 수영기록 상세정보를 불러옴
    func fetchSwimRecordByDay(date: Date) async throws -> DaySwimRecord
    ///HealthKit 권한 체크
    func requestAuthorization() async throws -> Bool
}

final class SwimRecordUsecaseImpl: SwimRecordUsecase {
    let repository: HealthKitRecordRepository
    
    init(repository: HealthKitRecordRepository) {
        self.repository = repository
    }
    
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> [SwimmingRecordList] {
        let result = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: start, end: end)
        var records = [SwimmingRecordList]()
        
        for workout in try await repository.fetchWorkoutSwimmingType(start: start, end: end) {
            let locationRawvalue = workout.metadata?[HKMetadataKeySwimmingLocationType] as? Int ?? 0
            let location = SwimmingLocationType(rawValue: locationRawvalue) ?? .unknown
            
            let startDate = workout.startDate.startOfDay()
            records.append(SwimmingRecordList(swimmingLocationType: location, workoutDates: startDate))
        }
        return records
    }
    
    func fetchSwimRecordByDay(date: Date) async throws -> DaySwimRecord {
        let startDate = date.startOfDay()
        let endDate = date.endOfDay()!
        
        let distanceResult = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: startDate, end: endDate)
        let strokeResult = try await repository.fetchDataByDateRange(type: .swimmingStrokeCount, start: startDate, end: endDate)
        
        let startActivityDate = [distanceResult.first?.startDate, strokeResult.first?.startDate].compactMap{$0}.max() ?? startDate
        let endActivityDate = [distanceResult.last?.endDate, strokeResult.last?.endDate].compactMap{$0}.max() ?? endDate
        
        var result = DaySwimRecord()
        result.totalActivityBurn = try await repository.fetchStatisticsQuery(type: .activeEnergyBurned, unit: .kilocalorie(), start: startActivityDate, end: endActivityDate, option: .cumulativeSum)
        var distanceIndex = 0
        var strokeIndex = 0
        
        while distanceIndex < distanceResult.count && strokeIndex < strokeResult.count {
            let distanceStartDate = distanceResult[distanceIndex].startDate
            let strokeStartDate = strokeResult[strokeIndex].startDate
            var strokeType: StrokeType?
            
            if distanceStartDate == strokeStartDate,
               let type = strokeResult[strokeIndex].metadata?[HKMetadataKeySwimmingStrokeStyle] as? Int
            {
                strokeType = StrokeType(rawValue: type)
            }
            
            let distance = distanceResult[distanceIndex].quantity.doubleValue(for: .meter())
            result.totalDistance += distance
            
            switch strokeType {
            case .freestyle:
                result.freeStyleDistance += distance
            case .backstroke:
                result.backstrokeDistance += distance
            case .breaststroke:
                result.breaststrokeDistance += distance
            case .butterfly:
                result.butterflyDistance += distance
            case .mixed:
                result.mixedDistance += distance
            case .kickboard:
                result.kickboardDistance += distance
            default: //.typeUnknown or nil
                result.unknownDistance += distance
                strokeIndex -= 1
            }
            
            strokeIndex += 1
            distanceIndex += 1
        }
        
        return result
    }
    
    func requestAuthorization() async throws -> Bool {
        try await repository.requestAuthorization()
    }
}

