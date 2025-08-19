//
//  HealthKitError.swift
//  Gliding
//
//  Created by 안정흠 on 8/19/25.
//


enum HealthKitError: Error {
    case authorizationDenied
    
    var localizedDescription: String {
        switch self {
        case .authorizationDenied:
            return "HealthKit authorization denied."
        }
    }
}