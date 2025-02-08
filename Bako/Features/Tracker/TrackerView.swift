//
//  TrackerView.swift
//  Bako
//
//  Created by Muhammad Rezky on 22/11/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

struct TrackerView: View {
    let store: StoreOf<TrackerReducer>
    @Query private var emotionList: [EmotionModel]

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        ForEach(DayType.allCases, id: \.self) { day in
                            Button {
                                viewStore.send(.selectDay(day))
                            } label: {
                                Text(day.initial)
                                    .foregroundColor(viewStore.state.selectedDay == day ? .darkBlue : .black)
                                    .frame(width: 36, height: 36)
                                    .background(viewStore.state.selectedDay == day ? .lighterBlue : .lighterGrey)
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
                        viewStore.send(.checkInButtonTapped)
                    }
                    Spacer().frame(height: 36)
                    VStack (alignment: .leading, spacing: 24) {
                        HStack {
                            Text(viewStore.checkInTitle)
                                .plusJakartaFont(.bold, 16)
                            Spacer()
                            Text(viewStore.formattedDate)
                                .plusJakartaFont(.regular, 12)
                                .opacity(0.4)
                        }
                        let filteredEmotions = emotionList.filter { emotion in
                            guard let date = emotion.date else { return false }
                            return Calendar.current.isDate(date, inSameDayAs: viewStore.selectedDate)
                        }
                        HStack(spacing: 16) {
                            HStack (spacing: 24) {
                                Text("\(filteredEmotions.filter { $0.category == .positive }.count)")
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
                                Text("\(filteredEmotions.filter { $0.category == .negative }.count)")
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
                            ForEach(filteredEmotions) { emotion in
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewStore.send(.toggleDatePicker)
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isDatePickerPresented,
                    send: .closeDatePicker
                )
            ) {
                NavigationView {
                    DatePicker(
                        "Select Date",
                        selection: viewStore.binding(
                            get: \.selectedDate,
                            send: { .selectDate($0) }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                    .navigationTitle("Select Date")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                viewStore.send(.closeDatePicker)
                            }
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
}

//#Preview {
//    TrackerView()
//}
