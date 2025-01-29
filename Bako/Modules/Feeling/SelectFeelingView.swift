import SwiftUI

struct EmotionCirclesView: View {
    var emotions: [EmotionModel]

    // State variables for panning
    @State private var currentOffset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    // Center circle scaling
    @State private var activeCircleIndex: Int?
    @State private var selectedEmotionIndex: Int?
    
    func getScaleFactorForIndex(index: Int) -> Double {
        let normalScale = 1.0       // Default size
        let centerScale = 1.1       // Slightly larger when near the center
        let selectedScale = 1.15     // Larger when selected

        // Check if the circle is selected 
        if index == selectedEmotionIndex {
            return selectedScale
        }

        // Check if the circle is near the center
        if index == activeCircleIndex {
            return centerScale
        }

        // Default case
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
                        .frame(
                            width: 160,
                            height: 160
                        )
                        .foregroundColor(index == selectedEmotionIndex ? .darkBlue : .lightestBlue)
                        .opacity(index == activeCircleIndex  ? 1 : 0.7)
                        .scaleEffect(getScaleFactorForIndex(index: index))
                        .overlay(
                            Text(emotion.feel)
                                .plusJakartaFont(.medium, 15)
                                .foregroundColor(index == selectedEmotionIndex  ? .white : .darkBlue)
                        )
                        .position(CGPoint(
                            x: originalPositions[index].x + currentOffset.width,
                            y: originalPositions[index].y + currentOffset.height
                        ))
                        .animation(.easeInOut(duration: 0.3), value: activeCircleIndex)
                        .onTapGesture {
                            withAnimation {
                                
                                    selectedEmotionIndex = index
                            }
                        }
                }
            }
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Calculate new offset
                        let newOffset = CGSize(
                            width: lastOffset.width + value.translation.width,
                            height: lastOffset.height + value.translation.height
                        )

                        // Limit the drag
                        currentOffset = limitDrag(newOffset, in: size, positions: originalPositions)

                        // Update the active circle index based on the adjusted positions
                        let adjustedPositions = originalPositions.map { position in
                            CGPoint(
                                x: position.x + currentOffset.width,
                                y: position.y + currentOffset.height
                            )
                        }
                        withAnimation{
                            activeCircleIndex = closestCircle(to: centerPoint, positions: adjustedPositions)
                        }
                    }
                    .onEnded { _ in
                        lastOffset = currentOffset
                    }
            )
        }
        .clipped()
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

struct SelectFeelingView: View {
    @State var routeToFormFeeling: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FormFeelingView(),
                isActive: $routeToFormFeeling) {}
            // Title Area
            HStack {
                Text("How do you feel?")
                    .plusJakartaFont(.bold, 24)
                Spacer()
            }
            .padding(24)
            .frame(maxWidth: .infinity)

            // Emotion Circles Area
            EmotionCirclesView(emotions: positiveEmotions)
                .frame(maxHeight: .infinity)

            // Footer Area
            Button {
                routeToFormFeeling = true
            } label: {
                Text("Continue")
                    .plusJakartaFont(.medium, 16)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.primaryBlue)
                    .foregroundColor(.white)
                    .cornerRadius(48)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    SelectFeelingView()
}
