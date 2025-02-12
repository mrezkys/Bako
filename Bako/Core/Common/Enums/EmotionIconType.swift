//
//  EmotionIconType.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import SwiftUI

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
