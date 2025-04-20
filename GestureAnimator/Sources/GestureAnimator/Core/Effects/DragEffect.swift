//
//  DragEffectModifier.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 18/04/2025.
//

import SwiftUI

public struct DragEffect: ViewModifier {
    @GestureState private var dragTranslation: CGSize = .zero
    @Binding var offset: CGSize
    @State private var internalOffset: CGSize = .zero
    private let animator: DragViewModel

    // Initializer for DragEffect
    public init(offset: Binding<CGSize>) {
        self._offset = offset
        self.animator = DragViewModel(initialOffset: offset.wrappedValue)  // Use the passed offset
    }

    public func body(content: Content) -> some View {
        content
            .offset(x: internalOffset.width + dragTranslation.width,
                    y: internalOffset.height + dragTranslation.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        animator.updateGesture(translation: value.translation) // Update the offset based on drag
                    }
                    .updating($dragTranslation) { value, state, _ in
                        state = value.translation // Update drag translation during gesture
                    }
                    .onEnded { final in
                        // Update the final gesture end state
                        animator.onGestureEnd(velocity: final.predictedEndTranslation) { newOffset in
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                internalOffset = newOffset
                                offset = newOffset
                            }
                        }
                    }
            )
    }
}

// Public API Entry
public extension View {
    func gestureDrag(offset: Binding<CGSize>) -> some View {
        self.modifier(DragEffect(offset: offset))
    }
}
