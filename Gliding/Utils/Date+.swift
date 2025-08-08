//
//  Date+.swift
//  Gliding
//
//  Created by 안정흠 on 8/3/25.
//

import Foundation

extension Date {
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self.startOfDay())
    }
    
    
    /// 해당 월의 첫날 (00:00:00)
    func startOfMonth() -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)
    }
    
    /// 해당 월의 마지막날 (23:59:59)
    func endOfMonth() -> Date? {
        guard let startOfMonth = self.startOfMonth() else { return nil }
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)
    }
    
    
    func dateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format//"yyyy-MM-dd" // 2020-08-13 16:30
        return dateFormatter.string(from: self) // 현재 시간의 Date를 format에 맞춰 string으로 반환
    }
    
    func caculateMonth(value: Int) -> Date? {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? Date()
        return calendar.date(byAdding: .month, value: value, to: startOfMonth)
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
