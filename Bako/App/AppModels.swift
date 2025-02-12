import SwiftData

enum AppModels {
    static let all: [any PersistentModel.Type] = [
        EmotionModel.self,
        // Add future models here
        // UserModel.self,
        // SettingsModel.self,
    ]
    
    @MainActor static func createContainer() throws -> ModelContainer {
        try SwiftDataClient.createContainer(for: all)
    }
} 
