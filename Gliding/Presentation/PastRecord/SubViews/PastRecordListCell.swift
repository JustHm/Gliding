//
//  PastRecordListCell.swift
//  Gliding
//
//  Created by 안정흠 on 9/1/25.
//

import SwiftUI

struct PastRecordListCell: View {
    let record: SwimRecordList
    var body: some View {
        VStack {
            HStack {
                Image(
                    systemName: record.swimmingLocationType == .pool ?
                    "figure.pool.swim" : "figure.openWater.swim"
                )
                Text(record.workoutDate.dateToString(format: "yyyy/MM/dd"))
                    .bold()
                Spacer()
                Text(Duration.seconds(record.duration), format: .time(pattern: .hourMinuteSecond))
                Image(systemName: "stopwatch")
            }
            
        }
        
    }
}

#Preview {
//    PastRecordListCell()
}
