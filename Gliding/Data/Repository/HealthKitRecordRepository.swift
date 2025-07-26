//
//  HealthKitRecordRepository.swift
//  Gliding
//
//  Created by 안정흠 on 7/24/25.
//

import Foundation
import HealthKit

enum HealthKitError: Error {
    case authorizationDenied
    
    var localizedDescription: String {
        switch self {
        case .authorizationDenied:
            return "HealthKit authorization denied."
        }
    }
}

protocol HealthKitRecordRepository {
    func fetchDistanceSwimmingByDateRange(start: Date, end: Date) async throws -> [HKQuantitySample]
    func fetchSwimmingStrokeCountByDateRange(start: Date, end: Date) async throws -> [HKQuantitySample]
    func fetchActivityEnergyBurned(start: Date, end: Date) async throws -> [HKQuantitySample]
    func requestAuthorization() async throws -> Bool
}

final class HealthKitRecordRepositoryImpl: HealthKitRecordRepository {
    
    private let store: HKHealthStore = HKHealthStore()
    private let read = Set([
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.distanceSwimming),
        HKQuantityType(.swimmingStrokeCount)
    ])
    
    
    func fetchDistanceSwimmingByDateRange(start: Date, end: Date) async throws -> [HKQuantitySample] {
        try await hasReadAuthorization()
        // Define the type.
        let swimType = HKQuantityType(.distanceSwimming)
        let rangeOfDate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        // Create the descriptor.
        let descriptor = HKSampleQueryDescriptor(predicates:[.quantitySample(type: swimType, predicate: rangeOfDate)], sortDescriptors: [])
        
        // Launch the query and wait for the results.
        // The system automatically sets results to [HKQuantitySample].
        return try await descriptor.result(for: store)
    }
    
    func fetchSwimmingStrokeCountByDateRange(start: Date, end: Date) async throws -> [HKQuantitySample] {
        try await hasReadAuthorization()
        // Define the type.
        let swimType = HKQuantityType(.swimmingStrokeCount)
        let rangeOfDate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        // Create the descriptor.
        let descriptor = HKSampleQueryDescriptor(predicates:[.quantitySample(type: swimType, predicate: rangeOfDate)], sortDescriptors: [])
        
        // Launch the query and wait for the results.
        // The system automatically sets results to [HKQuantitySample].
        return try await descriptor.result(for: store)
    }
    
    func fetchActivityEnergyBurned(start: Date, end: Date) async throws -> [HKQuantitySample] {
        try await hasReadAuthorization()
        // Define the type.
        let swimType = HKQuantityType(.activeEnergyBurned)
        let rangeOfDate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        // Create the descriptor.
        let descriptor = HKSampleQueryDescriptor(predicates:[.quantitySample(type: swimType, predicate: rangeOfDate)], sortDescriptors: [])
        
        // Launch the query and wait for the results.
        // The system automatically sets results to [HKQuantitySample].
        return try await descriptor.result(for: store)
    }
    
    func requestAuthorization() async throws -> Bool {
        guard HKHealthStore.isHealthDataAvailable() else { return false }
        try await store.requestAuthorization(toShare: [], read: read)
        // 요청 후 실제로 더 물어볼 필요가 없는지(=이미 허용됐는지) 확인
        return try await hasReadAuthorization()
    }
    
    @discardableResult
    private func hasReadAuthorization() async throws -> Bool {
        let status = try await store.statusForAuthorizationRequest(toShare: [], read: read)
        if status == .unnecessary { return true }
        else { throw HealthKitError.authorizationDenied }
    }
}
