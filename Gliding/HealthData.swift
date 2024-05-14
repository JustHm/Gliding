//
//  HealthData.swift
//  Gliding
//
//  Created by 안정흠 on 3/5/24.
//

import Foundation
import HealthKit

class HealthData {
    static let instance: HealthData = HealthData() //Swift Singleton은 생성에 한해서 Thread-safe
    
    private let store = HKHealthStore()
    private let workoutConfiguration: HKWorkoutActivityType = .swimming
    private let quantityIdentifier = [
        HKQuantityType(.distanceSwimming),
        HKQuantityType(.swimmingStrokeCount),
        HKQuantityType(.waterTemperature),
        
        HKQuantityType(.appleExerciseTime),
        HKQuantityType(.heartRate),
        
        HKQuantityType(.basalEnergyBurned),
        HKQuantityType(.activeEnergyBurned)
    ]
    
    func requestAuthorization() async throws {
        guard HKHealthStore.isHealthDataAvailable() else { throw HealthKitError.notExist}
        let read = Set(quantityIdentifier)
        let status = try await store.statusForAuthorizationRequest(toShare: [], read: read)
        
        switch status {
        case .unnecessary:
            break
        case .shouldRequest:
            try await store.requestAuthorization(toShare: [], read: read)
        case .unknown:
            throw HealthKitError.unknown
        @unknown default:
            throw HealthKitError.unknown
        }
        
        
        
    }
    
    func getSwimmingData() async throws {
        // Create a predicate for today's samples.
        let calendar = Calendar(identifier: .gregorian)
        let startDate = calendar.startOfDay(for: Date())
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        let today = HKQuery.predicateForSamples(withStart: startDate, end: endDate)


        // Create the query descriptor.
        let swimmingDistanceType = HKQuantityType(.distanceSwimming)
        let swimmingToday = HKSamplePredicate.quantitySample(type: swimmingDistanceType, predicate:today)
        let sumOfSwimmingQuery = HKStatisticsQueryDescriptor(predicate: swimmingToday, options: .cumulativeSum)


        // Run the query.
        let stepCount = try await sumOfSwimmingQuery.result(for: store)?
            .sumQuantity()?
            .doubleValue(for: HKUnit.count())


        // Use the step count here.
    }
}

enum HealthKitError: String, Error {
    case unknown = "설정 > 건강에 들어가서 뭐쩌구저쩌구"
    case notExist = "디바이스에 건강 앱이 존재하지 않습니다."
}
