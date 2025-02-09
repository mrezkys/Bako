//
//  AppStore.swift
//  Bako
//
//  Created by Muhammad Rezky on 29/01/25.
//

import ComposableArchitecture
import Foundation

let appStore = Store(
    initialState: AppReducer.State(
        path: StackState<Route>(),
        home: nil,  // Start with nil home state
        onboarding: OnboardingReducer.State()
    )
) {
    AppReducer()
        ._printChanges()
} withDependencies: {
    $0.userDefaults = .standard
}

