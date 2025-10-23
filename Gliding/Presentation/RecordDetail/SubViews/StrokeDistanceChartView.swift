//
//  StrokeDistanceChartView.swift
//  Gliding
//
//  Created by 안정흠 on 9/4/25.
//

import SwiftUI
import Charts

struct StrokeDistanceChartView: View {
    let record: DailySwimSummary
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.pool.swim")
                    .font(.headline)
                    .bold()
                Text("영법별 거리")
                    .font(.headline)
                    .bold()
                Spacer()
                Text("총 \(Int(record.totalDistance))M")
                    .font(.subheadline)
                    .bold()
            }
            
            Chart(StrokeType.allCases, id: \.self) { strokeType in
                let value = Int(record.distanceOfStyle[strokeType] ?? 0)
                BarMark(
                    x: .value("Distance", value),
                    stacking: .center
                )
                .foregroundStyle(by: .value("Stroke", strokeType.decription))
                .cornerRadius(8)
            }
            .frame(height: 50)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .padding(.bottom, 8)
            
            DisclosureGroup("자세히 보기") {
                Divider()
                ForEach(
                    StrokeType.allCases.filter { (record.distanceOfStyle[$0] ?? 0) > 0 },
                    id: \.self
                )
                { strokeType in
                    HStack {
                        let value = Int(record.distanceOfStyle[strokeType] ?? 0)
                        Text(strokeType.decription).font(.body)
                        Spacer()
                        Text("\(value)M").font(.body)
                    }
                    .padding(.vertical, 0.2)
                }
            }
            .tint(Color.primary)
            
        }
        .padding()
    }
}

