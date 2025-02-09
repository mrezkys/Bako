//
//  BakoApp.swift
//  Bako
//
//  Created by Muhammad Rezky on 19/11/24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct BakoApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: EmotionModel.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppView(
                    store: Store(
                        initialState: AppReducer.State(
                            modelContext: modelContainer.mainContext
                        ),
                        reducer: { AppReducer() },
                        withDependencies: {
                            $0.userDefaults = .standard
                        }
                    )
                    
                )
            }
        }
        .modelContainer(modelContainer)
    }
}
