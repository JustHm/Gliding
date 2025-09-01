//
//  RecordListViewModel.swift
//  Gliding
//
//  Created by 안정흠 on 8/8/25.
//
import Foundation
import Observation

enum RecordListType: String {
    case calendar = "calendar"
    case list = "list.bullet"
    
    mutating func toggle() {
        self = self == .calendar ? .list : .calendar
    }
}

@Observable
final class RecordListViewModel {
    @ObservationIgnored private let usecase: SwimRecordUsecase
    
    var calendarGrid: [[Date?]] = Array(repeating: Array(repeating: nil, count: 7), count: 6)
    var listType = RecordListType.list
    var selectedMonth: Date
    var recordList: [SwimmingRecordList] = []
    
    init(usecase: SwimRecordUsecase) {
        self.usecase = usecase
        self.selectedMonth = Date().startOfMonth()
    }
    
    
    private func fetchDates() {
        
    }
    
    func prevMonth() { shiftCalendar(value: -1) }
    
    func nextMonth() { shiftCalendar(value: 1) }
    
    private func shiftCalendar(value: Int) {
        guard let shifted = selectedMonth.caculateMonth(value: value)?.startOfMonth() else { return }
        selectedMonth = shifted
        fetchCalendarGrids()
    }
    
    func fetchCalendarGrids() {
        let startOffset =  3 //Calendar.monthStartOffset(<#T##self: Calendar##Calendar#>)
        
    }
    
    func fetchMonthlyRecords() async throws {
        let start = selectedMonth.startOfMonth()
        let end = selectedMonth.endOfMonth()
        
        recordList = try await usecase.fetchSwimRecordByMonthly(start: start, end: end)
    }
    
    func fetchSwimRecordByDate(_ date: Date) async throws -> DaySwimRecord {
        return try await usecase.fetchSwimRecordByDay(date: date)
    }
}
