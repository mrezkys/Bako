//
//  Route.swift
//  Bako
//
//  Created by Muhammad Rezky on 29/01/25.
//

import Foundation

enum Route: Equatable, Hashable {
    case home
    case onboarding
    case selectCategoryFeeling
    case selectFeeling
    case formFeeling
    case successSubmit
    case tracker
    case details(EmotionModel)
}
