//
//  RecordDetailView.swift
//  Gliding
//
//  Created by 안정흠 on 9/1/25.
//

import SwiftUI
import Charts

struct RecordDetailView: View {
    let selected: SwimRecordList
    @Bindable var viewModel: RecordListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(selected.workoutDate.dateToString(format: "yyyy년"))
                        .font(.title)
                        .bold()
                    Spacer()
                    if let swimSummary = viewModel.swimSummary {
                        HStack {
                            let start = swimSummary.startDate.dateToString(format: "HH:mm")
                            let end = swimSummary.endDate.dateToString(format: "HH:mm")
                            Text("\(start)~\(end)")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }
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
                
                if let swimSummary = viewModel.swimSummary {
                    StrokeDistanceChartView(record: swimSummary)
                        .background(Color.plane)
                        .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
                        .padding()
                }
                
                if let statusSummary = viewModel.statusSummary {
                    HeartRateChartView(statusSummary: statusSummary)
                        .background(Color.plane)
                        .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
                        .padding()
                }
                
                if let swimSummary = viewModel.swimSummary {
                    HStack {
                        Spacer()
                        Image(systemName: "applewatch")
                        Text("\(swimSummary.sourceRevision)")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                    .padding(.top, 4)
                }
                Spacer()
                
            }
        }
        .task {
            do {
                try await viewModel.fetchSwimRecordByDate(date: selected.workoutDate, duration: selected.duration)
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
