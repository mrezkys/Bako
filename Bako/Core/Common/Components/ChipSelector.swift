//
//  ChipSelector.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import SwiftUI

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
