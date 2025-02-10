//
//  FormFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 22/11/24.
//

import SwiftUI
import ComposableArchitecture

struct FormFeelingView: View {
    let store: StoreOf<FormFeelingReducer>
    @FocusState private var isTextFieldFocused: Bool
    @State private var showingActivityAlert = false
    @State private var showingPlaceAlert = false
    @State private var newItemText = ""
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                VStack(spacing: 0) {
                    ScrollView {
                        VStack {
                            // Emotion Header
                            VStack {
                                Image(viewStore.selectedEmotion?.iconType.image ?? EmotionIconType.cool.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 130)
                                Spacer().frame(height: 24)
                                Text("I'm Feeling")
                                    .plusJakartaFont(.medium, 16)
                                Spacer().frame(height: 4)
                                Text(viewStore.selectedEmotion?.feel ?? "")
                                    .plusJakartaFont(.bold, 24)
                                    .foregroundColor(.darkBlue)
                                Spacer().frame(height: 12)
                                Text(viewStore.currentDate.formatted(date: .abbreviated, time: .shortened))
                                    .plusJakartaFont(.regular, 12)
                                    .foregroundColor(.grey)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 32)
                            .frame(maxWidth: .infinity)
                            .background(.lightestGrey)
                            
                            // Form Content
                            VStack(spacing: 24) {
                                // Journal Section
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Today's Journal")
                                        .plusJakartaFont(.bold, 16)
                                    TextField(
                                        "Write what you feel here...",
                                        text: viewStore.binding(
                                            get: \.journal,
                                            send: { .updateJournal($0) }
                                        ),
                                        axis: .vertical
                                    )
                                    .focused($isTextFieldFocused)
                                    .frame(minHeight: 100, alignment: .top)
                                    .padding(16)
                                    .background(.lightestGrey)
                                    .cornerRadius(16)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Activities Section
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Activities")
                                        .plusJakartaFont(.bold, 16)
                                    ChipSelector(
                                        items: viewStore.activities,
                                        displayText: { $0 },
                                        onTapAdd: { showingActivityAlert = true },
                                        onTapItem: { item in
                                            viewStore.send(.selectActivity(item))
                                        },
                                        onRemoveItem: { item in
                                            viewStore.send(.removeCustomActivity(item))
                                        },
                                        isCustomItem: { item in
                                            viewStore.customActivities.contains(item)
                                        },
                                        selectedItem: viewStore.binding(
                                            get: \.selectedActivity,
                                            send: { .selectActivity($0) }
                                        )
                                    )
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Places Section
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Where")
                                        .plusJakartaFont(.bold, 16)
                                    ChipSelector(
                                        items: viewStore.places,
                                        displayText: { $0 },
                                        onTapAdd: { showingPlaceAlert = true },
                                        onTapItem: { item in
                                            viewStore.send(.selectPlace(item))
                                        },
                                        onRemoveItem: { item in
                                            viewStore.send(.removeCustomPlace(item))
                                        },
                                        isCustomItem: { item in
                                            viewStore.customPlaces.contains(item)
                                        },
                                        selectedItem: viewStore.binding(
                                            get: \.selectedPlace,
                                            send: { .selectPlace($0) }
                                        )
                                    )
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .scrollDismissesKeyboard(.immediately)
                    
                    // Save Button
                    Button {
                        isTextFieldFocused = false  // Dismiss keyboard when saving
                        viewStore.send(.saveButtonTapped)
                    } label: {
                        Text("Save")
                            .plusJakartaFont(.medium, 16)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryBlue)
                            .foregroundColor(.white)
                            .cornerRadius(48)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(.white)
                    .clipped()
                    .shadow(color: .grey.opacity(0.1), radius: 10, x: 0, y: -10)
                }
                .frame(maxWidth: .infinity)
            }
            .onTapGesture {
                isTextFieldFocused = false  // Dismiss keyboard when tapping outside
            }
            .alert("Add New Activity", isPresented: $showingActivityAlert) {
                TextField("Activity name", text: $newItemText)
                Button("Cancel", role: .cancel) {
                    newItemText = ""
                }
                Button("Add") {
                    if !newItemText.isEmpty {
                        viewStore.send(.addCustomActivity(newItemText))
                        newItemText = ""
                    }
                }
            }
            .alert("Add New Place", isPresented: $showingPlaceAlert) {
                TextField("Place name", text: $newItemText)
                Button("Cancel", role: .cancel) {
                    newItemText = ""
                }
                Button("Add") {
                    if !newItemText.isEmpty {
                        viewStore.send(.addCustomPlace(newItemText))
                        newItemText = ""
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        .navigationTitle("‎ ‎ Form Feeling‎ ‎ ")

    }
}

struct ChipSelector<T: Hashable>: View {
    let items: [T]
    let displayText: (T) -> String
    let onTapAdd: () -> Void
    let onTapItem: (T) -> Void
    let onRemoveItem: ((T) -> Void)?
    let isCustomItem: ((T) -> Bool)?
    @Binding var selectedItem: T
    @State private var itemToRemove: T?
    @State private var showingRemoveAlert = false

    var body: some View {
        createFlowLayout(maxWidth: UIScreen.main.bounds.width - 40)
            .alert("Remove Item", isPresented: $showingRemoveAlert, presenting: itemToRemove) { item in
                Button("Cancel", role: .cancel) {
                    itemToRemove = nil
                }
                Button("Remove", role: .destructive) {
                    if let onRemoveItem = onRemoveItem {
                        onRemoveItem(item)
                    }
                    itemToRemove = nil
                }
            } message: { item in
                Text("Do you want to remove '\(displayText(item))'?")
            }
    }

    private func createFlowLayout(maxWidth: CGFloat) -> some View {
        let adjustedMaxWidth = maxWidth - 32
        var currentRowWidth: CGFloat = 0
        var rows: [[T?]] = []
        let plusButtonWidth: CGFloat = 32

        // Start first row with the "+" button
        rows.append([nil])
        currentRowWidth = plusButtonWidth

        // Organize items into rows based on their dynamic width
        for item in items {
            let itemWidth = calculateWidth(for: displayText(item))
            
            // Check if adding this item would exceed adjustedMaxWidth
            if currentRowWidth + itemWidth + 10 > adjustedMaxWidth {
                // Start new row WITHOUT the "+" button
                rows.append([])
                currentRowWidth = 0
            }
            
            rows[rows.count - 1].append(item)
            currentRowWidth += itemWidth + 10
        }

        return VStack(alignment: .leading, spacing: 10) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { item in
                        if let item = item {
                            Text(displayText(item))
                                .padding()
                                .background(item == selectedItem ? .primaryBlue : .lightestGrey)
                                .foregroundColor(item == selectedItem ? .white : .black)
                                .cornerRadius(20)
                                .fixedSize()
                                .onTapGesture {
                                    onTapItem(item)
                                }
                                .onLongPressGesture {
                                    if let isCustom = isCustomItem?(item), isCustom {
                                        itemToRemove = item
                                        showingRemoveAlert = true
                                    }
                                }
                        } else {
                            // Render the "+" button with updated fixed width
                            Text("+")
                                .frame(width: plusButtonWidth)
                                .padding()
                                .background(.lightestGrey)
                                .cornerRadius(20)
                                .onTapGesture {
                                    onTapAdd()
                                }
                        }
                    }
                }
            }
        }
    }

    private func calculateWidth(for text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        let textWidth = text.size(withAttributes: [.font: font]).width
        return textWidth + 32 // Add padding (left + right)
    }
}

