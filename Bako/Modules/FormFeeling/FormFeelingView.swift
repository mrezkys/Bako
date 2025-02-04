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
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        VStack {
                            Image(EmotionIconType.cool.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 130)
                            Spacer().frame(height: 24)
                            Text("I'm Feeling")
                                .plusJakartaFont(.medium, 16)
                            Spacer().frame(height: 4)
                            Text("Affectionate")
                                .plusJakartaFont(.bold, 24)
                                .foregroundColor(.darkBlue)
                            Spacer().frame(height: 12)
                            Text("Fri, Jul 26 3:04 PM")
                                .plusJakartaFont(.regular, 12)
                                .foregroundColor(.grey)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity)
                        .background(.lightestGrey)
                        VStack(spacing: 24) {
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
                                .frame(minHeight: 100, alignment: .top)
                                .padding(16)
                                .background(.lightestGrey)
                                .cornerRadius(16)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Activities")
                                    .plusJakartaFont(.bold, 16)
                                ChipSelector(
                                    items: viewStore.activities,
                                    displayText: { $0 },
                                    onTapAdd: {
                                        print("Add tapped")
                                    },
                                    onTapItem: { item in
                                        viewStore.send(.selectActivity(item))
                                    },
                                    selectedItem: viewStore.binding(
                                        get: \.selectedActivity,
                                        send: { .selectActivity($0) }
                                    )
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Where")
                                    .plusJakartaFont(.bold, 16)
                                ChipSelector(
                                    items: viewStore.places,
                                    displayText: { $0 },
                                    onTapAdd: {
                                        print("Add tapped")
                                    },
                                    onTapItem: { item in
                                        viewStore.send(.selectPlace(item))
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
                Button {
                    viewStore.send(.saveButtonTapped)
                } label: {
                    Text("Save")
                        .plusJakartaFont(.medium, 16)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.primaryBlue)
                        .foregroundColor(.white)
                        .cornerRadius(48)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(.white)
                .clipped()
            }
            .frame(maxWidth: .infinity)
            .shadow(color: .grey.opacity(0.1), radius: 10, x: 0, y: -10)
        }
    }
}

struct ChipSelector<T: Hashable>: View {
    // Generic list of items
    let items: [T]
    // A way to extract the text from the generic type (e.g., item.name)
    let displayText: (T) -> String
    // Action for tapping the "+" button
    let onTapAdd: () -> Void
    // Action for tapping other items
    let onTapItem: (T) -> Void
    // Selected item to highlight
    @Binding var selectedItem: T

    var body: some View {
        // Use a fixed width from the parent container
        createFlowLayout(maxWidth: UIScreen.main.bounds.width - 40) // Adjust this width based on your layout
    }

    private func createFlowLayout(maxWidth: CGFloat) -> some View {
        var currentRowWidth: CGFloat = 0
        var rows: [[T?]] = [[nil]] // Always include "+" as the first element

        // Organize items into rows based on their dynamic width
        for item in items {
            let itemWidth = calculateWidth(for: displayText(item))
            if currentRowWidth + itemWidth + 10 > maxWidth { // Move to the next row
                currentRowWidth = 0
                rows.append([])
            }
            rows[rows.count - 1].append(item)
            currentRowWidth += itemWidth + 10 // Add item width + spacing
        }

        return VStack(alignment: .leading, spacing: 10) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { item in
                        if let item = item {
                            // Render a tappable chip for an item
                            Text(displayText(item))
                                .padding()
                                .background(item == selectedItem ? .primaryBlue : .lightestGrey)
                                .foregroundColor(item == selectedItem ? .white : .black)
                                .cornerRadius(20)
                                .fixedSize()
                                .onTapGesture {
                                    onTapItem(item)
                                }
                        } else {
                            // Render the "+" button
                            Text("+")
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

