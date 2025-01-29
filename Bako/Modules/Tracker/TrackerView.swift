//
//  TrackerView.swift
//  Bako
//
//  Created by Muhammad Rezky on 22/11/24.
//

import SwiftUI

struct TrackerView: View {
    @State var routeToSelectCategoryFeeling: Bool = false
    @State var selectedDay: DayType = .sunday
    var body: some View {
        ScrollView{
            NavigationLink(
                destination: SelectCategoryFeelingView(),
                isActive: $routeToSelectCategoryFeeling) {}
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    ForEach(DayType.allCases, id: \.self) { day in
                        Button {
                            selectedDay = day
                        } label: {
                            Text(day.initial)
                                .foregroundColor(selectedDay == day ? .darkBlue : .black)
                                .frame(width: 36, height: 36)
                                .background(selectedDay == day ? .lighterBlue : .lighterGrey)
                                .cornerRadius(18)
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                }
                Spacer().frame(height: 24)
                HStack(spacing: 12) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                    Text("Check in your mood")
                        .plusJakartaFont(.medium, 14)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .frame(height: 88)
                .background(
                    Image(.checkInIllustration)
                        .resizable()
                        .scaledToFill()
                )
                .cornerRadius(24)
                .onTapGesture {
                    routeToSelectCategoryFeeling = true
                }
                Spacer().frame(height: 36)
                VStack (alignment: .leading, spacing: 24) {
                    Text("Today’s Check In")
                        .plusJakartaFont(.bold, 16)
                    HStack(spacing: 16) {
                        HStack (spacing: 24) {
                            Text("1")
                                .plusJakartaFont(.bold, 18)
                            Text("Positive\nFeelings")
                                .plusJakartaFont(.medium, 14)
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)
                        .background(.lightestGrey)
                        .cornerRadius(24)
                        
                        HStack (spacing: 24) {
                            Text("1")
                                .plusJakartaFont(.bold, 18)
                            Text("Negative\nFeelings")
                                .plusJakartaFont(.medium, 14)
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)
                        .background(.lightestGrey)
                        .cornerRadius(24)
                    }
                    VStack (alignment: .leading, spacing: 16) {
                        ForEach(todayEmotions) { emotion in
                            EmotionCardView(emotion: emotion)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .navigationTitle("Mood Journey")
    }
}

#Preview {
    TrackerView()
}
