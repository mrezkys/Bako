//
//  FormFeelingView.swift
//  Bako
//
//  Created by Muhammad Rezky on 22/11/24.
//

import SwiftUI
import ComposableArchitecture

struct FormFeelingView: View {
    @Bindable var store: StoreOf<FormFeelingReducer>
    @FocusState private var isTextFieldFocused: Bool
    @State private var showingActivityAlert = false
    @State private var showingPlaceAlert = false
    @State private var newItemText = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        // Emotion Header
                        VStack {
                            Image(store.selectedEmotion?.iconType.image ?? EmotionIconType.cool.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                            Spacer().frame(height: 24)
                            Text("I'm Feeling")
                                .plusJakartaFont(.medium, 16)
                            Spacer().frame(height: 4)
                            Text(store.selectedEmotion?.feel ?? "")
                                .plusJakartaFont(.bold, 24)
                                .foregroundColor(.darkBlue)
                            Spacer().frame(height: 12)
                            Text(store.currentDate.formatted(date: .abbreviated, time: .shortened))
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
                                    text: $store.journal.sending(\.updateJournal),
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
                                    items: store.activities,
                                    displayText: { $0 },
                                    onTapAdd: { showingActivityAlert = true },
                                    onTapItem: { item in
                                        store.send(.selectActivity(item))
                                    },
                                    onRemoveItem: { item in
                                        store.send(.removeCustomActivity(item))
                                    },
                                    isCustomItem: { item in
                                        store.customActivities.contains(item)
                                    },
                                    selectedItem: $store.selectedActivity.sending(\.selectActivity)
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Places Section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Where")
                                    .plusJakartaFont(.bold, 16)
                                ChipSelector(
                                    items: store.places,
                                    displayText: { $0 },
                                    onTapAdd: { showingPlaceAlert = true },
                                    onTapItem: { item in
                                        store.send(.selectPlace(item))
                                    },
                                    onRemoveItem: { item in
                                        store.send(.removeCustomPlace(item))
                                    },
                                    isCustomItem: { item in
                                        store.customPlaces.contains(item)
                                    },
                                    selectedItem: $store.selectedPlace.sending(\.selectPlace)
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
                    store.send(.saveButtonTapped)
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
                    store.send(.addCustomActivity(newItemText))
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
                    store.send(.addCustomPlace(newItemText))
                    newItemText = ""
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .navigationTitle("‎ ‎ Form Feeling‎ ‎ ")

    }
}


