//
//  DayType.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import Foundation

enum DayType: Int, CaseIterable, Hashable {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    
    var initial: String {
        switch self {
        case .sunday:
            return "S"
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thursday:
            return "T"
        case .friday:
            return "F"
        case .saturday:
            return "S"
        }
    }
    
    static func fromWeekday(_ weekday: Int) -> DayType {
        // Calendar weekday is 1-based (Sunday = 1) but our enum is 0-based
        let adjustedWeekday = weekday - 1
        return DayType(rawValue: adjustedWeekday) ?? .sunday
    }
}
