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
    }
    
    enum Action: Equatable {
        case todaysMoodButtonTapped
        case delegate(Delegate)
        case emotionCardTapped(EmotionModel)
        case aboutButtonTapped
        
        enum Delegate: Equatable {
            case routeToTrackerView
            case routeToDetailFeeling(EmotionModel)
            case routeToAboutView
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .todaysMoodButtonTapped:
                return .send(.delegate(.routeToTrackerView))
            case .emotionCardTapped(let emotion):
                return .send(.delegate(.routeToDetailFeeling(emotion)))
            case .aboutButtonTapped:
                return .send(.delegate(.routeToAboutView))
            case .delegate:
                return .none
            }
        }
    }
}
