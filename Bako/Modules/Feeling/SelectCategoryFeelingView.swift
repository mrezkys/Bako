//
//  SelectCategoryFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 22/11/24.
//

import SwiftUI

struct SelectCategoryFeelingView: View {
    @State var routeToSelectFeeling: Bool = false
    
    @State var selectedEmotionCategory: EmotionCategory?

    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(
                            destination: SelectFeelingView(),
                            isActive: $routeToSelectFeeling) {}
            Text("Tap the color that represents your feeling right now")
                .plusJakartaFont(.bold, 24)
                .padding(.trailing, 24)
            Spacer()
            VStack(alignment: .center, spacing: 32) {
                Button {
                    withAnimation {
                        selectedEmotionCategory = .positive
                    }
                } label: {
                    Text("Positive\nFeelings")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 156)
                        .background(.darkBlue)
                        .cornerRadius(100)
                        .scaleEffect(selectedEmotionCategory == .positive ? 1.2 : 1)
                        .opacity(selectedEmotionCategory == .negative ? 0.5 : 1)
                }
                Button {
                    withAnimation {
                        selectedEmotionCategory = .negative
                    }
                } label: {
                    Text("Negative\nFeelings")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 156)
                        .background(.redEmotion)
                        .cornerRadius(100)
                        .cornerRadius(100)
                        .scaleEffect(selectedEmotionCategory == .negative ? 1.2 : 1)
                        .opacity(selectedEmotionCategory == .positive ? 0.5 : 1)
                }
            }
            Spacer()
            Button {
                routeToSelectFeeling = true
            } label: {
                Text("Continue")
                    .plusJakartaFont(.medium, 16)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryBlue)
                    .foregroundColor(.white)
                    .cornerRadius(48)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SelectCategoryFeelingView()
}
