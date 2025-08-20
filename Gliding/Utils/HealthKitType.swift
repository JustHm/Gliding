//
//  HealthKitType.swift
//  Gliding
//
//  Created by 안정흠 on 8/19/25.
//
import HealthKit

enum HealthKitType: CaseIterable {
    case activeEnergyBurned
    case distanceSwimming
    case swimmingStrokeCount
    case heartRate
    
    var quantityTypeIdentifier: HKQuantityTypeIdentifier {
        switch self {
        case .activeEnergyBurned:
            return .activeEnergyBurned
        case .distanceSwimming:
            return .distanceSwimming
        case .swimmingStrokeCount:
            return .swimmingStrokeCount
        case .heartRate:
            return .heartRate
        }
    }
}
