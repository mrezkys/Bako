//
//  HomeReducer.swift
//  Bako
//
//  Created by Muhammad Rezky on 03/02/25.
//


import Foundation
import ComposableArchitecture

@Reducer
struct HomeReducer {
    struct State: Equatable {
        var emotions: [EmotionModel] = todayEmotions
    }
    
    enum Action: Equatable {
        case todaysMoodButtonTapped
        case delegate(Delegate)
        enum Delegate: Equatable {
            case routeToTrackerView
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .todaysMoodButtonTapped:
                return .send(.delegate(.routeToTrackerView))
            case .delegate:
                return .none
            }
        }
    }
}
