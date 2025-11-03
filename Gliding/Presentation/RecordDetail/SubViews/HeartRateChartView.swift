//
//  HeartRateChartView.swift
//  Gliding
//
//  Created by 안정흠 on 9/5/25.
//

import SwiftUI
import Charts

struct HeartRateChartView: View {
    let statusSummary: DailyStatusSummary
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundStyle(Color.red)
                Text("심장박동수")
            }
            .font(.headline)
            .bold()
            .padding(.bottom, 8)
            
            
            
            Chart(statusSummary.heartRateBucket) { item in
                BarMark(
                    x: .value("Time", item.start, unit: .minute),
                    yStart: .value("BPM Min", item.minBPM),
                    yEnd: .value("BPM Max", item.maxBPM),
                    width: .fixed(10)
                )
                .clipShape(Capsule()).foregroundStyle(.red)
            }
            .chartYScale(domain: 50...250).frame(height: 150)
            
            HStack {
                block(image: "heart.fill", title: "최고", value: Int(statusSummary.heartRateMax), unit: "BPM")
                Spacer()
                block(image: "heart.fill", title: "평균", value: Int(statusSummary.heartRateAvg), unit: "BPM")
                Spacer()
                block(image: "flame", title: "활동칼로리", value: Int(statusSummary.totalActivityBurn), unit: "KCAL")
            }
            .padding(.top, 16)
        }
        .padding()
    }
    
    func block(image: String, title: String, value: Int, unit: String) -> some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: image)
                    .foregroundStyle(Color.red)
                Text(title).font(.headline)
            }
            HStack(alignment: .bottom) {
                Text("\(value)").font(.title2)
                Text(unit).font(.headline)
            }
            .padding(.top, 4)
        }
    }
}
