import Foundation
import ComposableArchitecture

extension DependencyValues {
    var userDefaults: UserDefaults {
        get { self[UserDefaultsKey.self] }
        set { self[UserDefaultsKey.self] = newValue }
    }
}

private enum UserDefaultsKey: DependencyKey {
    static let liveValue = UserDefaults.standard
}

