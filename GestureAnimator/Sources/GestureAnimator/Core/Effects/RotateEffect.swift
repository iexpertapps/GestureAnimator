//
//  RotateEffect.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI

public struct RotateEffect: ViewModifier {
    @GestureState private var gestureAngle: Angle = .zero
    @Binding var angle: Angle
    @State private var internalAngle: Angle = .zero
    private let animator: RotateViewModel

    public init(angle: Binding<Angle>) {
        self._angle = angle
        self.animator = RotateViewModel(initialAngle: angle.wrappedValue)
    }

    public func body(content: Content) -> some View {
        content
            .rotationEffect(internalAngle + gestureAngle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        // The `value` itself is already an `Angle`, so we directly pass it to `updateGesture`
                        animator.updateGesture(rotation: value)
                    }
                    .updating($gestureAngle) { value, state, _ in
                        // During the gesture, we update the `gestureAngle` state directly
                        state = value
                    }
                    .onEnded { final in
                        // For the final gesture, we pass the final angle and calculate the velocity if necessary
                        animator.onGestureEnd(velocity: final) { newAngle in
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                internalAngle = newAngle
                                angle = newAngle
                            }
                        }
                    }
            )
    }
}

public extension View {
    func gestureRotate(angle: Binding<Angle>) -> some View {
        self.modifier(RotateEffect(angle: angle))
    }
}
