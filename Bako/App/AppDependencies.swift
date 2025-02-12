import Foundation
import ComposableArchitecture
import SwiftData
import Dependencies

extension DependencyValues {
    var userDefaults: UserDefaults {
        get { self[UserDefaultsKey.self] }
        set { self[UserDefaultsKey.self] = newValue }
    }
}

private enum UserDefaultsKey: DependencyKey {
    static let liveValue = UserDefaults.standard
}

@MainActor
struct SwiftDataClient {
    var context: () -> ModelContext
    var save: () throws -> Void
    
    static func createContainer(for models: [any PersistentModel.Type]) throws -> ModelContainer {
        let schema = Schema(models)
        let modelConfiguration = ModelConfiguration(schema: schema)
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    }
}

extension DependencyValues {
    var swiftDataClient: SwiftDataClient {
        get { self[SwiftDataClient.self] }
        set { self[SwiftDataClient.self] = newValue }
    }
}

extension SwiftDataClient: DependencyKey {
    @MainActor
    static var liveValue: SwiftDataClient {
        let container = try! AppModels.createContainer()
        
        return SwiftDataClient(
            context: { container.mainContext },
            save: { try container.mainContext.save() }
        )
    }
}

