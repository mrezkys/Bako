//
//  Model.swift
//  Bako
//
//  Created by Muhammad Rezky on 08/02/25.
//

import SwiftUI
import SwiftData

@Model
final class EmotionModel: Identifiable, Equatable {
    var id: UUID
    var date: Date?
    var feel: String
    var journal: String
    var activities: String
    var place: String
    var iconType: EmotionIconType
    var category: EmotionCategory
    
    init(
        date: Date? = nil,
        feel: String,
        iconType: EmotionIconType,
        category: EmotionCategory
    ) {
        self.id = UUID()
        self.date = date
        self.feel = feel
        self.journal = ""
        self.activities = ""
        self.place = ""
        self.iconType = iconType
        self.category = category
    }
    
    static func == (lhs: EmotionModel, rhs: EmotionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
