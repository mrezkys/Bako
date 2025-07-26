//
//  TrackerReducer.swift
//  Bako
//
//  Created by Muhammad Rezky on 04/02/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TrackerReducer {
    @ObservableState
    struct State: Equatable {
        var selectedDay: DayType = DayType.fromWeekday(Calendar.current.component(.weekday, from: Date()))
        var selectedDate: Date = Date()
        var isDatePickerPresented: Bool = false
        
        var checkInTitle: String {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let selectedDate = calendar.startOfDay(for: self.selectedDate)
            
            if calendar.isDate(selectedDate, inSameDayAs: today) {
                return "Today's Check In"
            } else if selectedDate > today {
                return "Future Check In"
            } else {
                return "Past Check In"
            }
        }
        
        var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMM yyyy"
            return formatter.string(from: selectedDate)
        }
    }
    
    enum Action: Equatable {
        case selectDay(DayType)
        case selectDate(Date)
        case toggleDatePicker
        case closeDatePicker(Bool)
        case checkInButtonTapped
        case emotionCardTapped(EmotionModel)
        case delegate(Delegate)
        enum Delegate: Equatable {
            case routeToSelectCategoryFeeling
            case routeToDetailFeeling(EmotionModel)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .emotionCardTapped(let emotion):
                return .send(.delegate(.routeToDetailFeeling(emotion)))
                
            case .toggleDatePicker:
                state.isDatePickerPresented.toggle()
                return .none
                
            case let .closeDatePicker(isPresented):
                state.isDatePickerPresented = isPresented
                return .none
                
            case .selectDay(let day):
                state.selectedDay = day
                let calendar = Calendar.current
                let currentWeekday = calendar.component(.weekday, from: state.selectedDate)
                let targetWeekday = day.rawValue + 1
                let daysToAdd = targetWeekday - currentWeekday
                if let newDate = calendar.date(byAdding: .day, value: daysToAdd, to: state.selectedDate) {
                    state.selectedDate = newDate
                }
                return .none
                
            case .selectDate(let date):
                state.selectedDate = date
                state.selectedDay = DayType.fromWeekday(Calendar.current.component(.weekday, from: date))
                return .none
                
            case .checkInButtonTapped:
                return .send(.delegate(.routeToSelectCategoryFeeling))
                
            case .delegate:
                return .none
            }
        }
    }
}
