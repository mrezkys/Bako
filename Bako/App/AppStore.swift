//
//  AppStore.swift
//  Bako
//
//  Created by Muhammad Rezky on 29/01/25.
//

import ComposableArchitecture
import Foundation

let appStore = Store(
    initialState: AppReducer.State(),
    reducer: { AppReducer()._printChanges() }
)
