//
//  RecordDetailView.swift
//  Gliding
//
//  Created by 안정흠 on 9/1/25.
//

import SwiftUI

struct RecordDetailView: View {
    let selected: SwimmingRecordList
    @Bindable var viewModel: RecordListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selected.workoutDate.dateToString(format: "YYYY년"))
                .font(.title)
                .bold()
                .padding([.leading, .trailing, .top], 16)
                .padding([.bottom], 2)
            HStack {
                Text(selected.workoutDate.dateToString(format: "MM월 dd일 기록"))
                    .font(.title2)
                Spacer()
                Group {
                    Image(systemName: "stopwatch")
                    Text(Duration.seconds(selected.duration), format: .time(pattern: .hourMinuteSecond))
                }
                .font(.headline)
                .foregroundStyle(Color.gray)
            }
            .padding([.leading, .trailing], 16)
            
            if let record = viewModel.swimRecord {
                Text("\(record.totalActivityBurn)")
                Text("\(record.totalDistance)")
                Text("\(record.sourceRevision)")
                Text("\(record.distanceOfStyle[StrokeType.freestyle, default: -1])")
            }
            Spacer()
            
        }
        .task {
            do {
                try await viewModel.fetchSwimRecordByDate(selected.workoutDate)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
//    RecordDetailView()
}
