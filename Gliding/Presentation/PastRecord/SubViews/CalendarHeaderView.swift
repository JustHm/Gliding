//
//  CalendarHeaderView.swift
//  Gliding
//
//  Created by 안정흠 on 8/3/25.
//

import SwiftUI

struct CalendarHeaderView: View {
    @State var yearMonth: String = "2025년 8월"
    var body: some View {
        Text(yearMonth)
            .font(.title)
            .fontWeight(.semibold)
            .padding()
            .animation(.easeInOut, value: yearMonth)
    }
}

#Preview {
    CalendarHeaderView()
}
