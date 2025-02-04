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

extension DependencyValues {
    var userDefaults: UserDefaults {
        get { self[UserDefaultsKey.self] }
        set { self[UserDefaultsKey.self] = newValue }
    }
}

private enum UserDefaultsKey: DependencyKey {
    static let liveValue = UserDefaults.standard
}
