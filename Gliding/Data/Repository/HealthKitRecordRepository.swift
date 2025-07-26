//
//  HealthKitRecordRepository.swift
//  Gliding
//
//  Created by 안정흠 on 7/24/25.
//

import Foundation
import HealthKit

protocol HealthKitRecordRepository {
    func fetchSwimByDate(start: Date, end: Date) async throws -> [HKQuantitySample]
    func fetchHeartRateByDate(start: Date, end: Date) async throws -> [HKQuantitySample]
}

final class HealthKitRecordRepositoryImpl: HealthKitRecordRepository {
    private let store: HKHealthStore = HKHealthStore()
    
    func fetchSwimByDate(start: Date, end: Date) async throws -> [HKQuantitySample] {
        []
    }
    
    func fetchHeartRateByDate(start: Date, end: Date) async throws -> [HKQuantitySample] {
        []
    }
}
