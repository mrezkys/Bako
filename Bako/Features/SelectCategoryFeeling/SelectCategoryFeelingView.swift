//
//  SelectCategoryFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 22/11/24.
//

import SwiftUI
import ComposableArchitecture

struct SelectCategoryFeelingView: View {
    @Bindable var store: StoreOf<SelectCategoryFeelingReducer>
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer().frame(height: 16)
            Text("Tap the color that represents your feeling right now")
                .plusJakartaFont(.bold, 24)
                .padding(.trailing, 24)
            Spacer()
            VStack(alignment: .center, spacing: 32) {
                Button {
                    store.send(.selectEmotionCategory(.positive))
                } label: {
                    Text("Positive\nFeelings")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 156)
                        .background(.darkBlue)
                        .cornerRadius(100)
                        .scaleEffect(store.selectedEmotionCategory == .positive ? 1.2 : 1)
                        .opacity(store.selectedEmotionCategory == .negative ? 0.5 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: store.selectedEmotionCategory)
                }
                Button {
                    store.send(.selectEmotionCategory(.negative))
                } label: {
                    Text("Negative\nFeelings")
                        .foregroundColor(.white)
                        .frame(width: 156, height: 156)
                        .background(.redEmotion)
                        .cornerRadius(100)
                        .scaleEffect(store.selectedEmotionCategory == .negative ? 1.2 : 1)
                        .opacity(store.selectedEmotionCategory == .positive ? 0.5 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: store.selectedEmotionCategory)
                }
            }
            Spacer()
            Button {
                store.send(.continueButtonTapped)
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
        .navigationTitle("Select Category")
    }
}

//#Preview {
//    SelectCategoryFeelingView(store: Store(initialState: SelectCategoryFeelingReducer.State(), reducer: SelectCategoryFeelingReducer()))
//}
