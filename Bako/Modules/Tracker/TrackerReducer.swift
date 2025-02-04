//
//  TrackerReducer.swift
//  Bako
//
//  Created by Muhammad Rezky on 04/02/25.
//

import ComposableArchitecture

@Reducer
struct TrackerReducer {
    struct State: Equatable {
        var selectedDay: DayType = .sunday
    }
    
    enum Action: Equatable {
        case selectDay(DayType)
        case checkInButtonTapped
        case delegate(Delegate)
        enum Delegate: Equatable {
            case routeToSelectCategoryFeeling
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .selectDay(let day):
                state.selectedDay = day
                return .none
            case .checkInButtonTapped:
                return .send(.delegate(.routeToSelectCategoryFeeling))
                
            case .delegate:
                return .none
            }
        }
    }
}
