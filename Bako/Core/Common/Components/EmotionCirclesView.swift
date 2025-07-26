//
//  EmotionCirclesView.swift
//  Bako
//
//  Created by Muhammad Rezky on 13/02/25.
//

import SwiftUI
import ComposableArchitecture

struct EmotionCirclesView: View {
    var emotions: [EmotionModel]
    @Bindable var store: StoreOf<SelectFeelingReducer>

    func getScaleFactorForIndex(index: Int) -> Double {
        let normalScale = 1.0
        let centerScale = 1.05 
        let selectedScale = 1.10

        if index == store.selectedEmotionIndex {
            return selectedScale
        }

        if index == store.activeCircleIndex {
            return centerScale
        }

        return normalScale
    }

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let originalPositions = computeEmotionPositions(size: size, count: emotions.count)
            let centerPoint = CGPoint(x: size.width / 2, y: size.height / 2)

            ZStack {
                ForEach(Array(emotions.enumerated()), id: \.element.id) { index, emotion in
                    Circle()
                        .frame(width: 160, height: 160)
                        .foregroundColor(index == store.selectedEmotionIndex ? .darkBlue : .lightestBlue)
                        .opacity(index == store.activeCircleIndex ? 1 : 0.7)
                        .scaleEffect(getScaleFactorForIndex(index: index))
                        .overlay(
                            Text(emotion.feel)
                                .plusJakartaFont(.medium, 15)
                                .foregroundColor(index == store.selectedEmotionIndex ? .white : .darkBlue)
                        )
                        .position(CGPoint(
                            x: originalPositions[index].x + store.currentOffset.width,
                            y: originalPositions[index].y + store.currentOffset.height
                        ))
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: store.activeCircleIndex)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: store.selectedEmotionIndex)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: store.currentOffset)
                        .onTapGesture {
                            store.send(.selectEmotion(index))
                            
                            let selectedPosition = originalPositions[index]
                            let offsetToCenter = CGSize(
                                width: size.width/2 - selectedPosition.x,
                                height: size.height/2 - selectedPosition.y
                            )
                            
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                store.send(.updateOffset(offsetToCenter))
                                store.send(.setLastOffset(offsetToCenter))
                            }
                            
                            store.send(.updateActiveCircle(index))
                        }
                }
            }
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = CGSize(
                            width: store.lastOffset.width + value.translation.width,
                            height: store.lastOffset.height + value.translation.height
                        )

                        let limitedOffset = limitDrag(newOffset, in: size, positions: originalPositions)
                        
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            store.send(.updateOffset(limitedOffset))
                        }

                        let adjustedPositions = originalPositions.map { position in
                            CGPoint(
                                x: position.x + limitedOffset.width,
                                y: position.y + limitedOffset.height
                            )
                        }
                        store.send(.updateActiveCircle(closestCircle(to: centerPoint, positions: adjustedPositions)))
                    }
                    .onEnded { _ in
                        store.send(.setLastOffset(store.currentOffset))
                    }
            )
        }
        .clipped()
        .navigationTitle("Select Feeling")
    }

    func computeEmotionPositions(size: CGSize, count: Int) -> [CGPoint] {
          var positions: [CGPoint] = []
          let center = CGPoint(x: size.width / 2, y: size.height / 2)
          let circleSize: CGFloat = 160 // Updated to 160px
          let spacing: CGFloat = 20 // Increased spacing for larger circles
          let ringSpacing: CGFloat = circleSize + spacing

          if count > 0 {
              positions.append(center)
          }

          let totalEmotions = count - 1
          var emotionIndex = 0
          var ring = 1

          while emotionIndex < totalEmotions {
              let ringRadius = ringSpacing * CGFloat(ring)
              let circumference = 2 * CGFloat.pi * ringRadius
              let circlesInRing = max(Int(floor(circumference / (circleSize + spacing))), 1)
              let emotionsInThisRing = min(circlesInRing, totalEmotions - emotionIndex)

              for i in 0..<emotionsInThisRing {
                  let angle = (Double(i) / Double(emotionsInThisRing)) * 2 * .pi
                  let x = center.x + ringRadius * cos(CGFloat(angle))
                  let y = center.y + ringRadius * sin(CGFloat(angle))
                  positions.append(CGPoint(x: x, y: y))
              }

              emotionIndex += emotionsInThisRing
              ring += 1
          }

          return positions
      }

      func limitDrag(_ offset: CGSize, in size: CGSize, positions: [CGPoint]) -> CGSize {
          let padding: CGFloat = 160 // Increased padding for larger circles
          let minX = (positions.map { $0.x }.min() ?? 0) - padding
          let maxX = (positions.map { $0.x }.max() ?? 0) + padding
          let minY = (positions.map { $0.y }.min() ?? 0) - padding
          let maxY = (positions.map { $0.y }.max() ?? 0) + padding

          let horizontalLimit = (maxX - minX - size.width) / 2
          let verticalLimit = (maxY - minY - size.height) / 2

          return CGSize(
              width: min(max(offset.width, -horizontalLimit), horizontalLimit),
              height: min(max(offset.height, -verticalLimit), verticalLimit)
          )
      }

    func closestCircle(to point: CGPoint, positions: [CGPoint]) -> Int? {
        positions.enumerated()
            .min(by: { distance(from: $0.element, to: point) < distance(from: $1.element, to: point) })?.offset
    }

    func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return sqrt(dx * dx + dy * dy)
    }
}
