//
//  OnboardingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 19/11/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .leading) {
                VStack (alignment: .leading){
                    Text("Mood tracker")
                        .plusJakartaFont(.bold, 24)
                    Spacer().frame(height: 16)
                    Text("Get to know yourself better, trace, embrace and review to be better version of you!")
                        .plusJakartaFont(.medium, 16)
                        .lineSpacing(5)
                        .foregroundColor(.grey)
                }
                .padding(24)
                
                Spacer()
                Image("onboarding-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                    .frame(maxHeight: UIScreen.main.bounds.size.height * 0.7, alignment: .top)
                    .clipped()
                    .edgesIgnoringSafeArea(.bottom)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            VStack {
                Spacer()
                Button {} label: {
                    Text("Get Started")
                        .plusJakartaFont(.medium, 16)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryBlue)
                        .foregroundColor(.white)
                        .cornerRadius(48)
                        .padding(24)
                }
            }
        }
        
        
    }
}

#Preview {
    OnboardingView()
}
