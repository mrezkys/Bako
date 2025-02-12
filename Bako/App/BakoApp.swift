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
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppView(
                    store: appStore
                )
            }
            .preferredColorScheme(.light)
        }
        .modelContainer(try! AppModels.createContainer())
    }
}
