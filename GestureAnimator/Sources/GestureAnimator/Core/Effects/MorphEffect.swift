//
//  MorphEffect.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//
import Combine
import SwiftUI


/// A gesture effect that lets you morph between two shapes
public struct MorphEffect: ViewModifier {
    @GestureState private var morphValue: CGFloat = 0
    @Binding var progress: CGFloat
    @State private var internalProgress: CGFloat = 0
    private let animator: MorphViewModel
    private let style: MorphStyle

    public init(progress: Binding<CGFloat>, style: MorphStyle = .roundedToCircle) {
        self._progress = progress
        self.animator = MorphViewModel(initialProgress: progress.wrappedValue)
        self.style = style
    }

    public func body(content: Content) -> some View {
        content
            .clipShape(MorphingShape(progress: internalProgress + morphValue, style: style))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let delta = value.translation.width / 200
                        animator.updateGesture(translation: delta) // Use `updateGesture` instead of `onGestureChange`
                    }
                    .updating($morphValue) { value, state, _ in
                        state = value.translation.width / 200
                    }
                    .onEnded { final in
                        let predicted = final.predictedEndTranslation.width / 200
                        animator.onGestureEnd(velocity: predicted) { finalProgress in
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                internalProgress = finalProgress
                                progress = finalProgress
                            }
                        }
                    }
            )
    }
}

public extension View {
    func gestureMorph(progress: Binding<CGFloat>, style: MorphStyle = .roundedToCircle) -> some View {
        self.modifier(MorphEffect(progress: progress, style: style))
    }
}

/// Supported morphing styles
public enum MorphStyle {
    case roundedToCircle
    case capsuleToStar
}

/// A shape that morphs between styles based on progress.
public struct MorphingShape: Shape {
    
    public var progress: CGFloat
    public var style: MorphStyle

    public init(progress: CGFloat, style: MorphStyle) {
        self.progress = progress
        self.style = style
    }

    public func path(in rect: CGRect) -> Path {
        switch style {
        case .roundedToCircle:
            let clamped = min(max(progress, 0), 1)
            let radius = clamped * min(rect.width, rect.height) / 2
            return RoundedRectangle(cornerRadius: radius).path(in: rect)

        case .capsuleToStar:
            return blendedCapsuleToStar(progress: progress, in: rect)
        }
    }

    public var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    private func blendedCapsuleToStar(progress: CGFloat, in rect: CGRect) -> Path {
        let capsulePath = Capsule().path(in: rect).normalizedPoints()
        let starPath = starPath(in: rect).normalizedPoints()

        guard capsulePath.count == starPath.count else {
            return Capsule().path(in: rect)
        }

        let interpolated = zip(capsulePath, starPath).map { (a, b) in
            CGPoint(
                x: a.x + (b.x - a.x) * progress,
                y: a.y + (b.y - a.y) * progress
            )
        }

        return Path { path in
            guard let first = interpolated.first else { return }
            path.move(to: first)
            for point in interpolated.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
    }

    private func starPath(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let points = 5
        let radius = min(rect.width, rect.height) / 2
        let angle = .pi * 2 / CGFloat(points * 2)

        for i in 0..<points * 2 {
            let length = i.isMultiple(of: 2) ? radius : radius * 0.4
            let x = center.x + length * cos(CGFloat(i) * angle - .pi / 2)
            let y = center.y + length * sin(CGFloat(i) * angle - .pi / 2)

            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        path.closeSubpath()
        return path
    }
}


// MARK: - Path interpolation support

extension Path {
    func normalizedPoints(sampleCount: Int = 180) -> [CGPoint] {
        
        let length = self.trimmedPath(from: 0, to: 1).length ?? 1.0

        return stride(from: 0.0, through: 1.0, by: 1.0 / Double(sampleCount)).map { t in
            let offset = CGFloat(t) * length
            return self.point(at: offset, totalLength: length) ?? .zero
        }
    }

    var length: CGFloat? {
        var total: CGFloat = 0
        var previous: CGPoint?

        self.forEach { element in
            switch element {
            case .move(to: let p):
                previous = p
            case .line(to: let p):
                if let prev = previous {
                    total += hypot(p.x - prev.x, p.y - prev.y)
                }
                previous = p
            case .closeSubpath:
                break
            default:
                break
            }
        }

        return total > 0 ? total : nil
    }

    func point(at offset: CGFloat, totalLength: CGFloat) -> CGPoint? {
        var traversed: CGFloat = 0
        var previous: CGPoint?

        var result: CGPoint?

        self.forEach { element in
            switch element {
            case .move(to: let p):
                previous = p
            case .line(to: let p):
                if let prev = previous {
                    let segment = hypot(p.x - prev.x, p.y - prev.y)
                    if traversed + segment >= offset {
                        let remaining = offset - traversed
                        let t = remaining / segment
                        result = CGPoint(x: prev.x + (p.x - prev.x) * t,
                                         y: prev.y + (p.y - prev.y) * t)
                        return
                    } else {
                        traversed += segment
                    }
                }
                previous = p
            case .closeSubpath:
                break
            default:
                break
            }
        }

        return result
    }
}
