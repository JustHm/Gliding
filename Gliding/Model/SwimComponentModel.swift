//
//  SwimComponentModel.swift
//  Gliding
//
//  Created by 안정흠 on 3/5/24.
//

import Foundation

struct SwimComponentModel {
    var name: String
    var type: StrokeType
    var lane: Int //lane distance 25,50,100
    var rep: Int
    var timeLimit: Int
    var description: String
    var items: [Item]
    var effort: Int
}

enum StrokeType {
    case freestyle
    case backstroke
    case breaststroke
    case butterfly
    case drill
    case other
}

enum Item {
    case fin
    case pullBuoy
    case kickboard
    case paddle //손 패들
}
