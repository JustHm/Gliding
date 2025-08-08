//
//  SwimRecordUsecase.swift
//  Gliding
//
//  Created by 안정흠 on 7/26/25.
//

import Foundation
//import HealthKit

protocol SwimRecordUsecase {
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> MonthlySwimRecord
    func fetchSwimRecordByDay(date: Date) async throws -> DaySwimRecord
    func requestAuthorization() async throws -> Bool
}

enum StrokeType: Int {
    case typeUnknown = 0
    case mixed
    case freestyle
    case backstroke
    case breaststroke
    case butterfly
    case kickboard
    
    var decription: String {
        switch self {
        case .typeUnknown: return "Unknown"
        case .mixed: return "Mixed"
        case .freestyle: return "Freestyle"
        case .backstroke: return "Backstroke"
        case .breaststroke: return "Breaststroke"
        case .butterfly: return "Butterfly"
        case .kickboard: return "Kickboard"
        }
    }
}

final class SwimRecordUsecaseImpl: SwimRecordUsecase {
    let repository: HealthKitRecordRepository
    
    init(repository: HealthKitRecordRepository) {
        self.repository = repository
    }
    
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> MonthlySwimRecord {
        let result = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: start, end: end)
        var monthlySwimRecord = MonthlySwimRecord(totalDistance: 0.0, workoutDates: [])
        var dates: Set<Date> = []
        
        for workout in result {
            // 한 달 간 수행한 거리
            monthlySwimRecord.totalDistance += workout.quantity.doubleValue(for: .meter())
            
            // 중복 제거를 위해 | 혹시라도 12시 넘어가는 세션 있을까봐
            let startDate = workout.startDate.startOfDay()
            let endDate = workout.endDate.startOfDay()
            
            dates.insert(startDate)
            dates.insert(endDate)
        }
        
        monthlySwimRecord.workoutDates = dates.sorted(by: <)
        return monthlySwimRecord
    }
    
    func fetchSwimRecordByDay(date: Date) async throws -> DaySwimRecord {
        let startDate = date.startOfDay()
        let endDate = date.endOfDay()!
        
        let distanceResult = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: startDate, end: endDate)
        let strokeResult = try await repository.fetchDataByDateRange(type: .swimmingStrokeCount, start: startDate, end: endDate)
        //        let energyBurnResult = try await repository.fetchDataByDateRange(type: .activeEnergyBurned, start: Date(), end: Date())
        
        var distanceIndex = 0
        var strokeIndex = 0
        
        print("DISTANCE: ")
        for i in distanceResult {
            print(i)
        }
        
        print("Stroke: ")
        for j in strokeResult {
            print(j)
        }
        
        while distanceIndex < distanceResult.count && strokeIndex < strokeResult.count {
            if distanceResult[distanceIndex].startDate == strokeResult[strokeIndex].startDate {
                
            }
            
            
        }
        
        return DaySwimRecord(totalDistance: 0, totalTime: 0, activityBurn: 0, freeStyleDistance: 0, backstrokeDistance: 0, breaststrokeDistance: 0, butterflyDistance: 0, sourceRevision: "")
    }
    
    func requestAuthorization() async throws -> Bool {
        try await repository.requestAuthorization()
    }
}

