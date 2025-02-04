//
//  HomeView.swift
//  Bako
//
//  Created by Muhammad Rezky on 21/11/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    ZStack(alignment: .leading) {
                        Image("home-illustration")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 335)
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Today might be rough, but you passed it! How you'd feel, Mala?")
                                .plusJakartaFont(.medium, 16)
                                .lineSpacing(5)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
                            Button {
                                store.send(.todaysMoodButtonTapped)
                            } label: {
                                HStack(spacing: 8){
                                    Text("Today's Mood")
                                        .plusJakartaFont(.medium, 14)
                                    Image(systemName: "arrow.right")
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.primaryBlue)
                                .cornerRadius(48)
                            }
                        }
                        .padding(24)
                    }
                    VStack (alignment: .leading, spacing: 16) {
                        Text("Today's Check In")
                            .plusJakartaFont(.bold, 16)
                        EmotionTimelineView(emotions: .constant(todayEmotions))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

#Preview {
    HomeView(
        store: Store(
            initialState: HomeReducer.State()
        ) {
            HomeReducer()
        }
    )
}

// Define the TimelineModel
struct TimelineModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
}

struct EmotionModel: Identifiable, Equatable {
    let id = UUID()
    var date: Date?
    let feel: String
    var journal: String = ""
    var activities: String = ""
    var place: String = ""
    let iconType: EmotionIconType
    let category: EmotionCategory
}

enum EmotionIconType: String {
    case affectionate
    case cool
    case exhausted
    case smile
    
    var image: String {
        switch self {
        case .affectionate:
            return "affectionate-emotion-icon"
        case .cool:
            return "cool-emotion-icon"
        case .exhausted:
            return "exhausted-emotion-icon"
        case .smile:
            return "smile-emotion-icon"
        }
    }
    
    var color: Color {
        switch self {
        case .affectionate:
                .black
        case .cool:
                .black
        case .exhausted:
            Color(.greenEmotion)
        case .smile:
            Color(.redEmotion)
        }
    }
}

enum EmotionCategory {
    case positive
    case negative
}

struct EmotionTimelineView: View {
    @Binding var emotions: [EmotionModel]
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


struct EmotionCardView: View {
    var emotion: EmotionModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 24){
                    VStack(alignment: .leading) {
                        Text("Fri, Jul 26")
                            .plusJakartaFont(.regular, 12)
                            .foregroundColor(.grey)
                        Text("3:03 PM")
                            .plusJakartaFont(.regular, 12)
                            .foregroundColor(.grey)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Feeling")
                            .plusJakartaFont(.regular, 12)
                        Text("Exhausted")
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

enum DayType: CaseIterable, Hashable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var initial: String {
        switch self {
        case .sunday:
            return "S"
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thursday:
            return "T"
        case .friday:
            return "F"
        case .saturday:
            return "S"
        }
    }
}


var todayEmotions: [EmotionModel] = [
    EmotionModel(
        date: Date.now,
        feel: "Exhausted",
        iconType: .exhausted,
        category: .negative
    ),
    EmotionModel(
        date: Date.now,
        feel: "Thankful",
        iconType: .smile,
        category: .positive
    ),
    EmotionModel(
        date: Date.now,
        feel: "Confident",
        iconType: .cool,
        category: .positive
    ),
    EmotionModel(
        date: Date.now,
        feel: "Exhausted",
        iconType: .affectionate,
        category: .negative
    ),
]
