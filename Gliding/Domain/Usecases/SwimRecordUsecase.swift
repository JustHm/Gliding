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
    func fetchSwimRecordByDay() async throws -> DaySwimRecord
    func requestAuthorization() async throws -> Bool
}

final class SwimRecordUsecaseImpl: SwimRecordUsecase {
    let repository: HealthKitRecordRepository
    
    init(repository: HealthKitRecordRepository) {
        self.repository = repository
    }
    
    func fetchSwimRecordByMonthly(start: Date, end: Date) async throws -> MonthlySwimRecord {
        let result = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: start, end: end)
        var monthlySwimRecord = MonthlySwimRecord(totalDistance: 0.0, workoutDates: [])
        
        for workout in result {
            // 한 달 간 수행한 거리
            monthlySwimRecord.totalDistance += workout.quantity.doubleValue(for: .meter())
            
            // 중복 제거를 위해 | 혹시라도 12시 넘어가는 세션 있을까봐
            let startDate = workout.startDate.dateNormalize()
            let endDate = workout.endDate.dateNormalize()
            
            monthlySwimRecord.workoutDates.insert(startDate)
            monthlySwimRecord.workoutDates.insert(endDate)
        }
        return monthlySwimRecord
    }
    
    func fetchSwimRecordByDay() async throws -> DaySwimRecord {
        let distanceResult = try await repository.fetchDataByDateRange(type: .distanceSwimming, start: Date(), end: Date())
        let strokeResult = try await repository.fetchDataByDateRange(type: .swimmingStrokeCount, start: Date(), end: Date())
        let energyBurnResult = try await repository.fetchDataByDateRange(type: .activeEnergyBurned, start: Date(), end: Date())
        
    }
    
    func requestAuthorization() async throws -> Bool {
        try await repository.requestAuthorization()
    }
}

extension Date {
    func dateNormalize() -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    
    func dateToString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 2020-08-13 16:30
        let str = dateFormatter.string(from: self) // 현재 시간의 Date를 format에 맞춰 string으로 반환
    }
}
