//
//  HealthKitRecordRepository.swift
//  Gliding
//
//  Created by 안정흠 on 7/24/25.
//

import Foundation
import HealthKit

protocol HealthKitRecordRepository {
    ///수영 기록이 오픈워터, 풀인지 반환
    func fetchWorkoutSwimmingType(start: Date, end: Date) async throws -> [HKWorkout]
    ///타입과 일치하며 일정 범위에 맞는 데이터를 전부 반환
    func fetchDataByDateRange(type: HealthKitType, start: Date, end: Date) async throws -> [HKQuantitySample]
    ///합계, 평균, 최소, 최대 등의 통계를 반환
    func fetchStatisticsQuery(type: HealthKitType, unit: HKUnit, start: Date, end: Date, option: HKStatisticsOptions) async throws -> Double
    ///고정간격을 기준으로 시계열 통계를 반환
    func fetchStatisticsCollectionQuery(type: HealthKitType, start: Date, end: Date, option: HKStatisticsOptions)
    ///HealthKit 권한 체크
    func requestAuthorization() async throws -> Bool
}

final class HealthKitRecordRepositoryImpl: HealthKitRecordRepository {
    private let store: HKHealthStore = HKHealthStore()
    private let read: Set<HKObjectType>
    
    init(read: Set<HKQuantityType>? = nil) {
        if let read = read {
            self.read = read
        }
        else {
            self.read = Set(
                HealthKitType.allCases.compactMap{HKObjectType.quantityType(forIdentifier: $0.quantityTypeIdentifier)} +
                [HKObjectType.workoutType(), HKSeriesType.workoutRoute()]
            )
        }
    }
    
    func fetchWorkoutSwimmingType(start: Date, end: Date) async throws -> [HKWorkout] {
        try await hasReadAuthorization()
        
        let swimType = HKQuery.predicateForWorkouts(with: .swimming)
        let rangeOfDate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [swimType, rangeOfDate])
        
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.workout(compoundPredicate)],
            sortDescriptors: [.init(\.startDate, order: .forward)]
        )
        
        return try await descriptor.result(for: store)
    }
    
    func fetchDataByDateRange(type: HealthKitType, start: Date, end: Date) async throws -> [HKQuantitySample] {
        try await hasReadAuthorization()
        
        let swimType = HKQuantityType(type.quantityTypeIdentifier)
        let rangeOfDate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        let descriptor = HKSampleQueryDescriptor(predicates:[.quantitySample(type: swimType, predicate: rangeOfDate)], sortDescriptors: [.init(\.startDate, order: .forward)])
        
        return try await descriptor.result(for: store)
    }

    
    func fetchStatisticsQuery(
        type: HealthKitType,
        unit: HKUnit,
        start: Date,
        end: Date,
        option: HKStatisticsOptions
    ) async throws -> Double {
        try await hasReadAuthorization()
        
        let quantityType = HKQuantityType(type.quantityTypeIdentifier)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
        
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: .quantitySample(type: quantityType, predicate: predicate),
            options: option
        )
        
        let stats = try await descriptor.result(for: store)
        
        switch option {
        case .cumulativeSum: // 누적합계
            return stats?.sumQuantity()?.doubleValue(for: unit) ?? 0

        case .discreteAverage: // 샘플들의 평균값
            return stats?.averageQuantity()?.doubleValue(for: unit) ?? 0

        case .discreteMin: // 최솟값
            return stats?.minimumQuantity()?.doubleValue(for: unit) ?? 0

        case .discreteMax: // 최댓값
            return stats?.maximumQuantity()?.doubleValue(for: unit) ?? 0

        case .mostRecent: // 최근 기록된 값
            return stats?.mostRecentQuantity()?.doubleValue(for: unit) ?? 0
        default:
            return 0
        }
    }
    
    func fetchStatisticsCollectionQuery(
        type: HealthKitType,
        start: Date,
        end: Date,
        option: HKStatisticsOptions
    ) {
//        HKStatisticsCollectionQuery
        //HKStatisticsCollectionQueryDescriptor
    }

    
    func requestAuthorization() async throws -> Bool {
        guard HKHealthStore.isHealthDataAvailable() else { return false }
        try await store.requestAuthorization(toShare: [], read: read)
        // 요청 후 한 번 더 물어볼 필요가 없는지 확인
        return try await hasReadAuthorization()
    }
    
    @discardableResult
    private func hasReadAuthorization() async throws -> Bool {
        let status = try await store.statusForAuthorizationRequest(toShare: [], read: read)
        if status == .unnecessary { return true }
        else { throw HealthKitError.authorizationDenied }
    }
}
