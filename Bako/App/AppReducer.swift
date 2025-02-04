//
//  AppReducer.swift
//  Bako
//
//  Created by Muhammad Rezky on 29/01/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppReducer {
    struct State: Equatable {
        var path = StackState<Route>()
        var home: HomeReducer.State?
        var tracker: TrackerReducer.State?
        var onboarding: OnboardingReducer.State
        var selectCategoryFeeling: SelectCategoryFeelingReducer.State?
        var selectFeeling: SelectFeelingReducer.State?
        var formFeeling: FormFeelingReducer.State?
        
        init(
            path: StackState<Route> = StackState<Route>(),
            home: HomeReducer.State? = nil,
            tracker: TrackerReducer.State? = nil,
            onboarding: OnboardingReducer.State = OnboardingReducer.State(),
            selectCategoryFeeling: SelectCategoryFeelingReducer.State? = nil,
            selectFeeling: SelectFeelingReducer.State? = nil,
            formFeeling: FormFeelingReducer.State? = nil
        ) {
            self.path = path
            self.home = home
            self.tracker = tracker
            self.onboarding = onboarding
            self.selectCategoryFeeling = selectCategoryFeeling
            self.selectFeeling = selectFeeling
            self.formFeeling = formFeeling
        }
    }
    
    enum Action {
        case path(StackAction<Route, Never>)
        case home(HomeReducer.Action)
        case tracker(TrackerReducer.Action)
        case onboarding(OnboardingReducer.Action)
        case selectCategoryFeeling(SelectCategoryFeelingReducer.Action)
        case selectFeeling(SelectFeelingReducer.Action)
        case formFeeling(FormFeelingReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none
                
            case .home(.delegate(.routeToTrackerView)):
                state.tracker = TrackerReducer.State()
                state.path.append(.tracker)
                return .none
                
            case .home:
                return .none
                
            case .tracker(.delegate(.routeToSelectCategoryFeeling)):
                state.selectCategoryFeeling = SelectCategoryFeelingReducer.State()
                state.path.append(.selectCategoryFeeling)
                return .none
                
            case .tracker:
                return .none
                
            case .onboarding(.delegate(.completed)):
                state.home = HomeReducer.State()
                return .none
                
            case .onboarding:
                return .none
                
            case .selectCategoryFeeling(.delegate(.routeToSelectFeeling)):
                let emotions = state.selectCategoryFeeling?.selectedEmotionCategory == .positive ? 
                    positiveEmotions : negativeEmotions
                state.selectFeeling = SelectFeelingReducer.State(emotions: emotions)
                state.path.append(.selectFeeling)
                return .none
                
            case .selectFeeling(.delegate(.routeToFormFeeling)):
                if let selectedIndex = state.selectFeeling?.selectedEmotionIndex,
                   let selectedEmotion = state.selectFeeling?.emotions[selectedIndex] {
                    state.formFeeling = FormFeelingReducer.State(selectedEmotion: selectedEmotion)
                    state.path.append(.formFeeling)
                }
                return .none
                
            case .selectFeeling:
                return .none
                
            case .formFeeling(.delegate(.routeToSuccessSubmit)):
                state.path.append(.successSubmit)
                return .none
                
            case .formFeeling:
                return .none
                
            case .selectCategoryFeeling:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            EmptyReducer()
        }
        .ifLet(\.home, action: \.home) {
            HomeReducer()
        }
        .ifLet(\.tracker, action: \.tracker) {
            TrackerReducer()
        }
        Scope(state: \.onboarding, action: \.onboarding) {
            OnboardingReducer()
        }
        .ifLet(\.selectCategoryFeeling, action: \.selectCategoryFeeling) {
            SelectCategoryFeelingReducer()
        }
        .ifLet(\.selectFeeling, action: \.selectFeeling) {
            SelectFeelingReducer()
        }
        .ifLet(\.formFeeling, action: \.formFeeling) {
            FormFeelingReducer()
        }
    }
}
