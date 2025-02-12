//
//  EmotionTimelineView.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import SwiftUI

struct EmotionTimelineView: View {
    @Binding var emotions: [EmotionModel]
    var didTapEmotion: ((EmotionModel) -> ())
    var body: some View {
        // Right Side Content
        VStack(alignment: .leading, spacing: 0) {
            ForEach(emotions.indices, id: \.self) { index in
                let emotion = emotions[index]
                HStack (alignment: .center, spacing: 20){
                    VStack {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.darkBlue)
                    }
                    EmotionCardView(emotion: emotion)
                        .padding(.bottom, 16)
                        .onTapGesture {
                            didTapEmotion(emotion)
                        }
                }
                .background(
                    HStack {
                        Spacer().frame(width: 10 - 1)
                        VStack {
                            Rectangle()
                                .frame(width: 2)
                                .foregroundColor(.darkBlue)
                                .opacity(index == 0 ? 0 : 1)
                            Rectangle()
                                .frame(width: 2)
                                .foregroundColor(.darkBlue)
                                .opacity(emotions.count - 1 == index ? 0 : 1)
                        }
                        Spacer()
                    }
                )
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

