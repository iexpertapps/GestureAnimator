//
//  CustomPathEffect.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI

/// Applies gesture-driven animation along a parametric path.
public struct CustomPathEffect: ViewModifier {
    @GestureState private var gestureProgress: CGFloat = 0
    @Binding var progress: CGFloat
    private let path: (CGFloat) -> CGPoint

    public init(progress: Binding<CGFloat>, path: @escaping (CGFloat) -> CGPoint) {
        self._progress = progress
        self.path = path
    }

    public func body(content: Content) -> some View {
        let effectiveProgress = progress + gestureProgress
        let point = path(effectiveProgress)

        return content
            .offset(x: point.x, y: point.y)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                       // let delta = value.translation.width / 300
                        // gestureProgress handles this
                    }
                    .updating($gestureProgress) { value, state, _ in
                        state = value.translation.width / 300
                    }
                    .onEnded { final in
                        let predicted = final.predictedEndTranslation.width / 300
                        let finalValue = progress + predicted
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            progress = finalValue
                        }
                    }
            )
    }
}

public extension View {
    /// Animates the view along a custom parametric path controlled by gesture.
    func gestureCustomPath(progress: Binding<CGFloat>, path: @escaping (CGFloat) -> CGPoint) -> some View {
        self.modifier(CustomPathEffect(progress: progress, path: path))
    }
}
