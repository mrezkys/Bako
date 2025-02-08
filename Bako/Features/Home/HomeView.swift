//
//  HomeView.swift
//  Bako
//
//  Created by Muhammad Rezky on 21/11/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

struct HomeView: View {
    let store: StoreOf<HomeReducer>
    @Query private var emotionList: [EmotionModel]
    
    var todayEmotions: [EmotionModel] {
        emotionList.filter { emotion in
            guard let date = emotion.date else { return false }
            return Calendar.current.isDate(date, inSameDayAs: Date())
        }
    }
    
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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 24){
                    VStack(alignment: .leading) {
                        Text(dateFormatter.string(from: emotion.date ?? Date()))
                            .plusJakartaFont(.regular, 12)
                            .foregroundColor(.grey)
                        Text(timeFormatter.string(from: emotion.date ?? Date()))
                            .plusJakartaFont(.regular, 12)
                            .foregroundColor(.grey)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Feeling")
                            .plusJakartaFont(.regular, 12)
                        Text(emotion.feel)
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

