//
//  StrokeType.swift
//  Gliding
//
//  Created by 안정흠 on 8/19/25.
//


enum StrokeType: Int, CaseIterable {
    case typeUnknown = 0
    case mixed
    case freestyle
    case backstroke
    case breaststroke
    case butterfly
    case kickboard
    
    var decription: String {
        switch self {
        case .typeUnknown: return "알수없음"
        case .mixed: return "혼영"
        case .freestyle: return "자유형"
        case .backstroke: return "배영"
        case .breaststroke: return "평형"
        case .butterfly: return "접영"
        case .kickboard: return "킥판"
        }
    }
}
//case .typeUnknown: return "Unknown"
//case .mixed: return "Mixed"
//case .freestyle: return "Freestyle"
//case .backstroke: return "Backstroke"
//case .breaststroke: return "Breaststroke"
//case .butterfly: return "Butterfly"
//case .kickboard: return "Kickboard"
