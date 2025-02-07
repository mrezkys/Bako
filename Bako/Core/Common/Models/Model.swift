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

// Define the TimelineModel
struct TimelineModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
}

enum EmotionIconType: String, Codable {
    case affectionate
    case cool
    case exhausted
    case smile
    
    var image: String {
        switch self {
        case .affectionate:
            return "affectionate-emotion-icon"
        case .cool:
            return "cool-emotion-icon"
        case .exhausted:
            return "exhausted-emotion-icon"
        case .smile:
            return "smile-emotion-icon"
        }
    }
    
    var color: Color {
        switch self {
        case .affectionate:
                .black
        case .cool:
                .black
        case .exhausted:
            Color(.greenEmotion)
        case .smile:
            Color(.redEmotion)
        }
    }
}

enum EmotionCategory: String, Codable {
    case positive
    case negative
}
