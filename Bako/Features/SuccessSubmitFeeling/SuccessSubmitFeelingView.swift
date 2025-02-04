//
//  SuccessSubmitFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 24/11/24.
//

import SwiftUI

struct SuccessSubmitFeelingView: View {
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Image(.applauseIllustration)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                Spacer().frame(height: 56)
                Text("Thank You for Sharing Your Feelings!")
                    .plusJakartaFont(.bold, 24)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                Spacer().frame(height: 24)
                Text("Every step you take brings you closer to understanding yourself better. Great job for checking in today 😁")
                    .plusJakartaFont(.regular, 16)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                Spacer().frame(height: 16)
                Text("Your feelings matter. Take a moment to reflect, breathe, and embrace your emotions")
                    .plusJakartaFont(.regular, 16)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                Spacer()
            }
            .padding(36)
            Button {} label: {
                Text("Return to Home")
                    .plusJakartaFont(.medium, 16)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryBlue)
                    .foregroundColor(.white)
                    .cornerRadius(48)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SuccessSubmitFeelingView()
}
