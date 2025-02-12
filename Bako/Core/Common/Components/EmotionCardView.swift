//
//  EmotionCardView.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import SwiftUI

struct EmotionCardView: View {
    var emotion: EmotionModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 24){
                    VStack(alignment: .leading) {
                        Text(dateFormatter.string(from: emotion.date ?? Date()))
                            .plusJakartaFont(.regular, 12)
                            .foregroundColor(.grey)
                        Text(timeFormatter.string(from: emotion.date ?? Date()))
                            .plusJakartaFont(.regular, 12)
                            .foregroundColor(.grey)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Feeling")
                            .plusJakartaFont(.regular, 12)
                        Text(emotion.feel)
                            .plusJakartaFont(.medium, 18)
                            .foregroundColor(
                                emotion.iconType.color
                            )
                    }
                }
                Spacer()
                Image(emotion.iconType.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.lightestGrey)
        .cornerRadius(12)
    }
}
