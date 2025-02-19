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
    
    var lastFiveEmotions: [EmotionModel] {
        Array(emotionList.suffix(5))
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
                            Text("Today might be rough, but you passed it! How do you feel today?")
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
                        if !lastFiveEmotions.isEmpty {
                            Text("Last Check-in")
                                .plusJakartaFont(.bold, 16)
                            EmotionTimelineView(
                                emotions: .constant(lastFiveEmotions),
                                didTapEmotion: { emotion in
                                    store.send(.emotionCardTapped(emotion))
                                }
                            )
                        }
                        HStack{
                            Text("About App")
                                .foregroundColor(.grey)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.grey)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.lightestGrey)
                        .cornerRadius(12)
                        .onTapGesture {
                            store.send(.aboutButtonTapped)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

