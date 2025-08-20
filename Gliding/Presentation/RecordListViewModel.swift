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
    @ObservationIgnored private var usecase: SwimRecordUsecase
    
    var currentYear: Int
    var currentMonth: Int
    var listType = RecordListType.list
    var calendarDates: [[Date]] = [[Date]]()
    var calendarSelection: Int = 1
//    var swimRecrods: MonthlySwimRecord = MonthlySwimRecord(totalDistance: 0, workoutDates: [])
    
    init(usecase: SwimRecordUsecase) {
        self.usecase = usecase
        self.currentYear = Int(Date().dateToString(format: "yyyy"))!
        self.currentMonth = Int(Date().dateToString(format: "MM"))!
    }
    
    
    private func fetchDates() {
        
    }
    
    func prevMonth() {
        
    }
    
    func nextMonth() {
        
    }
    
    func fetchSwimRecords() async throws {
        guard let startDate = Date.createDate(year: currentYear, month: currentMonth, day: 1),
              let endDate = startDate.endOfMonth()
        else { throw DateError.connotCreateDate }
        
        do {
            _ = try await usecase.fetchSwimRecordByMonthly(start: startDate, end: endDate)
        }
        catch {
            throw error
        }
    }
}


enum DateError: Error {
    case connotCreateDate
}
