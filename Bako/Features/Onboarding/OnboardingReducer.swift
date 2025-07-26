//
//  OnboardingReducer.swift
//  Bako
//
//  Created by Muhammad Rezky on 29/01/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct OnboardingReducer {
    @ObservableState
    struct State: Equatable {
        var hasSeenOnboarding: Bool = false
    }
    
    enum Action: Equatable {
        case onAppear
        case getStartedTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case completed
        }
    }
    
    @Dependency(\.userDefaults) var userDefaults
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let hasSeen = userDefaults.bool(forKey: "hasSeenOnboarding")
                if hasSeen {
                    return .send(.delegate(.completed))
                }
                return .none
                
            case .getStartedTapped:
                userDefaults.set(true, forKey: "hasSeenOnboarding")
                state.hasSeenOnboarding = true
                return .send(.delegate(.completed))
                
            case .delegate:
                return .none
            }
        }
    }
}
