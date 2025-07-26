//
//  DetailFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 08/02/25.
//

import SwiftUI
import ComposableArchitecture

struct DetailFeelingView: View {
    @Bindable var store: StoreOf<DetailFeelingReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    // Emotion Header
                    VStack {
                        Image(store.emotion.iconType.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130, height: 130)
                        Spacer().frame(height: 24)
                        Text("I'm Feeling")
                            .plusJakartaFont(.medium, 16)
                        Spacer().frame(height: 4)
                        Text(store.emotion.feel)
                            .plusJakartaFont(.bold, 24)
                            .foregroundColor(.darkBlue)
                        Spacer().frame(height: 12)
                        if let date = store.emotion.date {
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .plusJakartaFont(.regular, 12)
                                .foregroundColor(.grey)
                        }
                        Spacer().frame(height: 24)
                        HStack(spacing: 8){
                            Text(store.emotion.activities)
                                    .padding()
                                    .background(.primaryBlue)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .fixedSize()
                                Text(store.emotion.place)
                                    .padding()
                                    .background(.primaryBlue)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .fixedSize()
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 32)
                    .frame(maxWidth: .infinity)
                    .background(.lightestGrey)
                    VStack {
                        Text(store.emotion.journal)
                            .plusJakartaFont(.medium, 16)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .padding(24)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Feeling Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DetailFeelingView()
//}
