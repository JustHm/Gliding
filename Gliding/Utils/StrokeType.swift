//
//  StrokeType.swift
//  Gliding
//
//  Created by 안정흠 on 8/19/25.
//


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