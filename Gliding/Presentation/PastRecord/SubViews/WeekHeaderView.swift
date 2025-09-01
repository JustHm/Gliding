//
//  WeekHeaderView.swift
//  Gliding
//
//  Created by 안정흠 on 8/3/25.
//

import SwiftUI

struct WeekHeaderView: View {
    private let week: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        HStack {
            ForEach(week, id: \.self) { day in
                Text(day)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                // 만약 일요일이라면 글씨색 red
                    .foregroundStyle(day == "일" ? Color.red : Color.black)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    WeekHeaderView()
}
