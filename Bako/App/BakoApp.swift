//
//  BakoApp.swift
//  Bako
//
//  Created by Muhammad Rezky on 19/11/24.
//

import SwiftUI
import SwiftData

@main
struct BakoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppView(store: appStore)
            }
        }
        .modelContainer(for: EmotionModel.self)
    }
}
