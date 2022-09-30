//
//  misc.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation


extension Bool {
    func toInt() -> Int {
        return self ? 1 : 0
    }
}

extension Int {
    func toBool() -> Bool {
        return (self <= 0) ? false : true
    }
}

extension Int {
    func toTaskSpan() -> TaskSpan {
        switch self {
        case 1:
            return .day
        case 2:
            return .week
        case 3:
            return .biweek
        case 4:
            return .month
        case 5:
            return .year
        default:
            return .year
        }
    }
}

func getEndDate(startDate: Date, span: TaskSpan) -> Date{
    switch span {
    case .day:
        return calendar.date(byAdding: .day, value: 1, to: startDate)!
    case .week:
        return calendar.date(byAdding: .day, value: 7, to: startDate)!
    case .biweek:
        return calendar.date(byAdding: .day, value: 14, to: startDate)!
    case .month:
        return calendar.date(byAdding: .month, value: 1, to: startDate)!
    case .year:
        return calendar.date(byAdding: .year, value: 1, to: startDate)!
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
