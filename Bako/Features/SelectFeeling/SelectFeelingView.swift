import SwiftUI
import ComposableArchitecture

struct SelectFeelingView: View {
    @Bindable var store: StoreOf<SelectFeelingReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            // Title Area
            HStack {
                Text("How do you feel?")
                    .plusJakartaFont(.bold, 24)
                Spacer()
            }
            .padding(24)
            .frame(maxWidth: .infinity)

            // Emotion Circles Area
            EmotionCirclesView(
                emotions: store.emotions,
                store: store
            )
            .frame(maxHeight: .infinity)

            // Footer Area
            Button {
                store.send(.continueButtonTapped)
            } label: {
                Text("Continue")
                    .plusJakartaFont(.medium, 16)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.primaryBlue)
                    .foregroundColor(.white)
                    .cornerRadius(48)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
