//
//  Date+.swift
//  Gliding
//
//  Created by 안정흠 on 8/3/25.
//

import Foundation

extension Date {
    /// 해당 일의 첫날 (00:00:00)
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// 해당 일의 마지막날 (23:59:59)
    func endOfDay() -> Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self.startOfDay())
    }
    
    /// 해당 월의 첫날 (00:00:00)
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    /// 해당 월의 마지막날 (23:59:59)
    func endOfMonth() -> Date {
        let startOfMonth = self.startOfMonth()
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    /// 포맷에 따라 String 형태로 반환
    func dateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format//"yyyy-MM-dd" // 2020-08-13 16:30
        return dateFormatter.string(from: self)
    }
    
    func caculateMonth(value: Int) -> Date? {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? Date()
        return calendar.date(byAdding: .month, value: value, to: startOfMonth)
    }
    
    func monthStartOffset() -> Int {
        let weekday = Calendar.current.component(.weekday, from: self.startOfMonth())
        return (weekday - Calendar.current.firstWeekday + 7) % 7
    }
    
    func daysInMonth() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: self)!.count
    }
    
    static func createDate(year: Int, month: Int, day: Int?) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        
        if let day { components.day = day }
        else { components.day = 1 }
        
        return Calendar.current.date(from: components)
    }
}

extension Calendar {
    /// 그 달의 총 일수
    func daysInMonth(for date: Date) -> Int {
        range(of: .day, in: .month, for: date)!.count
    }
    
    /// 캘린더 첫 요일(firstWeekday)에 정렬했을 때 1일의 시작 오프셋(0~6)
    /// - 예) firstWeekday=2(월요일 시작)이고 1일이 수요일(weekday=4)이면 (4-2+7)%7 = 2
    func monthStartOffset(for date: Date) -> Int {
        let first = date.startOfMonth()
        let weekdayOfFirst = component(.weekday, from: first) // 1=일 ~ 7=토 (Gregorian 기본)
        return (weekdayOfFirst - firstWeekday + 7) % 7
    }
}
