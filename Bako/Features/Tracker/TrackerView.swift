import SwiftUI
import ComposableArchitecture
import SwiftData

struct TrackerView: View {
    @Bindable var store: StoreOf<TrackerReducer>
    @Query private var emotionList: [EmotionModel]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                daySelectionView
                Spacer().frame(height: 24)
                checkInButtonView
                Spacer().frame(height: 36)
                emotionsSummaryView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .navigationTitle("Mood Journey")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    store.send(.toggleDatePicker)
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(
            isPresented: $store.isDatePickerPresented.sending(\.closeDatePicker)
        ) {
            datePickerSheet
        }
    }

    private var daySelectionView: some View {
        HStack {
            ForEach(DayType.allCases, id: \.self) { day in
                Button {
                    store.send(.selectDay(day))
                } label: {
                    Text(day.initial)
                        .foregroundColor(store.selectedDay == day ? .darkBlue : .black)
                        .frame(width: 36, height: 36)
                        .background(store.selectedDay == day ? .lighterBlue : .lighterGrey)
                        .cornerRadius(18)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var checkInButtonView: some View {
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
            store.send(.checkInButtonTapped)
        }
    }

    private var emotionsSummaryView: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text(store.checkInTitle)
                    .plusJakartaFont(.bold, 16)
                Spacer()
                Text(store.formattedDate)
                    .plusJakartaFont(.regular, 12)
                    .opacity(0.4)
            }
            emotionCountsView
            emotionListView
        }
    }

    private var emotionCountsView: some View {
        HStack(spacing: 16) {
            let filteredEmotions = emotionList.filter { emotion in
                guard let date = emotion.date else { return false }
                return Calendar.current.isDate(date, inSameDayAs: store.selectedDate)
            }
            HStack(spacing: 24) {
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

            HStack(spacing: 24) {
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
    }

    // Extracted view for emotion list
    private var emotionListView: some View {
        VStack(alignment: .leading, spacing: 16) {
            let filteredEmotions = emotionList.filter { emotion in
                guard let date = emotion.date else { return false }
                return Calendar.current.isDate(date, inSameDayAs: store.selectedDate)
            }
            ForEach(filteredEmotions) { emotion in
                EmotionCardView(emotion: emotion)
                    .onTapGesture {
                        store.send(.emotionCardTapped(emotion))
                    }
            }
        }
    }

    private var datePickerSheet: some View {
        NavigationView {
            DatePicker(
                "Select Date",
                selection: $store.selectedDate.sending(\.selectDate),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        store.send(.closeDatePicker(false))
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
