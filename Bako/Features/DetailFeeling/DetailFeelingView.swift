//
//  DetailFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 08/02/25.
//

import SwiftUI
import ComposableArchitecture

struct DetailFeelingView: View {
    let store: StoreOf<DetailFeelingReducer>
    
    var body: some View {
        WithViewStore(store, observe: \.emotion) { viewStore in
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        // Emotion Header
                        VStack {
                            Image(viewStore.iconType.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                            Spacer().frame(height: 24)
                            Text("I'm Feeling")
                                .plusJakartaFont(.medium, 16)
                            Spacer().frame(height: 4)
                            Text(viewStore.feel)
                                .plusJakartaFont(.bold, 24)
                                .foregroundColor(.darkBlue)
                            Spacer().frame(height: 12)
                            if let date = viewStore.date {
                                Text(date.formatted(date: .abbreviated, time: .omitted))
                                    .plusJakartaFont(.regular, 12)
                                    .foregroundColor(.grey)
                            }
                            Spacer().frame(height: 24)
                            HStack(spacing: 8){
                                Text(viewStore.activities)
                                        .padding()
                                        .background(.primaryBlue)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                        .fixedSize()
                                    Text(viewStore.place)
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
                            Text(viewStore.journal)
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
}

//#Preview {
//    DetailFeelingView()
//}
