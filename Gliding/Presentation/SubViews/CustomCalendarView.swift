//
//  CustomCalendarView.swift
//  Gliding
//
//  Created by 안정흠 on 8/3/25.
//

import SwiftUI

struct CustomCalendarView: View {
    @Binding var months: [[Date]] // 각 달의 날짜 배열
    @Binding var selection: Int // TabView 현재 선택 인덱스
    
    var body: some View {
        VStack {
            WeekHeaderView()
            TabView(selection: $selection) {
                ForEach(0..<3) { idx in
                    MonthGrid(dates: months[idx])
                        .tag(idx)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .onAppear {
            let today = Date()
            months = [
                today.addingMonth(-1).allDatesInMonth(),
                today.allDatesInMonth(),
                today.addingMonth(+1).allDatesInMonth()
            ]
        }
        .onChange(of: selection, { old, new in
            let centerDate = months[selection].first! // 각 월 배열의 첫 Date
            if new == 0 {
                // ← 스와이프: 왼쪽(이전달)
                let prev = centerDate.addingMonth(-1)
                months.insert(prev.allDatesInMonth(), at: 0)
                months.removeLast()
            }
            else if new == 2 {
                // → 스와이프: 오른쪽(다음달)
                let next = centerDate.addingMonth(+1)
                months.append(next.allDatesInMonth())
                months.removeFirst()
            }
            // 항상 가운데 페이지로 돌아오기
            selection = 1
        })
    }
}

/// 달의 각 날짜를 Grid로 보여주는 뷰 (예시)
struct MonthGrid: View {
    let dates: [Date]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(dates, id: \.self) { date in
                Text("\(date.day)")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Date Helpers

extension Date {
    /// 이번 달(또는 오프셋에 따라 이전/다음달) 모든 날짜를 반환
    func allDatesInMonth() -> [Date] {
        var calendar = Calendar.current
        calendar.timeZone = .current
        let start = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: start)!
        return range.map { calendar.date(byAdding: .day, value: $0 - 1, to: start)! }
    }
    
    /// 월 단위로 더하기/빼기
    func addingMonth(_ offset: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: offset, to: self)!
    }
    
    /// Date에서 일(day)만 꺼내주는 편의 프로퍼티
    var day: Int { Calendar.current.component(.day, from: self) }
}
