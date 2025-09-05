//
//  HealthKitRecordRepository.swift
//  Gliding
//
//  Created by 안정흠 on 7/24/25.
//

import Foundation
import HealthKit
import CoreLocation

protocol HealthKitRecordRepository {
    ///수영 기록이 오픈워터, 풀인지 반환
    func fetchWorkoutSwimmingType(start: Date, end: Date) async throws -> [HKWorkout]
    ///타입과 일치하며 일정 범위에 맞는 데이터를 전부 반환
    func fetchDataByDateRange(type: HealthKitType, start: Date, end: Date) async throws -> [HKQuantitySample]
    ///합계, 평균, 최소, 최대 등의 통계를 반환
    func fetchStatisticsQuery(type: HealthKitType, unit: HKUnit, start: Date, end: Date, options: HKStatisticsOptions) async throws -> Double
    ///고정간격을 기준으로 시계열 통계를 반환
    func fetchStatisticsCollectionQuery(type: HealthKitType, start: Date, end: Date, options: HKStatisticsOptions, interval: DateComponents) async throws -> HKStatisticsCollection
    ///수영기록 중 오픈워터일때 이동경로를 반환
    func fetchOpenWaterRoute(workout: HKWorkout) async throws -> [CLLocationCoordinate2D]
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
        options: HKStatisticsOptions
    ) async throws -> Double {
        try await hasReadAuthorization()
        
        let quantityType = HKQuantityType(type.quantityTypeIdentifier)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
        
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: .quantitySample(type: quantityType, predicate: predicate),
            options: options
        )
        
        let stats = try await descriptor.result(for: store)
        
        switch options {
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
        options: HKStatisticsOptions,
        interval: DateComponents = DateComponents(minute: 1)
    ) async throws -> HKStatisticsCollection {
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        let quantityType = HKQuantityType(type.quantityTypeIdentifier)
        let sameplePredicate = HKSamplePredicate.quantitySample(type: quantityType, predicate: predicate)
        
        let descriptor = HKStatisticsCollectionQueryDescriptor(predicate: sameplePredicate, options: options, anchorDate: start, intervalComponents: interval)
        
        return try await descriptor.result(for: store)
    }
    
    func fetchOpenWaterRoute(workout: HKWorkout) async throws -> [CLLocationCoordinate2D] {
        try await hasReadAuthorization()
        
        let predicate = HKQuery.predicateForObjects(from: workout)
        let routeType = HKSeriesType.workoutRoute()
        
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.sample(type: routeType, predicate: predicate)],
            sortDescriptors: [.init(\.startDate, order: .forward)]
        )
        let routes = try await (descriptor.result(for: store) as? [HKWorkoutRoute]) ?? []

       var coordinators: [CLLocation] = []
       for route in routes {
           let locations = HKWorkoutRouteQueryDescriptor(route).results(for: store)
           for try await location in locations {
               coordinators.append(location)
           }
       }

       return coordinators.sorted { $0.timestamp < $1.timestamp }.map(\.coordinate)
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
