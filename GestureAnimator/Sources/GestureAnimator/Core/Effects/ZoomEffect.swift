//
//  ZoomEffectModifier.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 18/04/2025.
//

import SwiftUI


public struct ZoomEffect: ViewModifier {
    @GestureState private var gestureScale: CGFloat = 1.0
    @Binding var scale: CGFloat
    @State private var internalScale: CGFloat = 1.0
    
    public init(scale: Binding<CGFloat>) {
        self._scale = scale
    }

    public func body(content: Content) -> some View {
        content
            .scaleEffect(internalScale * gestureScale)
            .gesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in
                        state = value
                    }
                    .onEnded { finalValue in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            internalScale *= finalValue
                            scale = internalScale
                        }
                    }
            )
    }
}

// Public API Entry
public extension View {
    func gestureZoom(scale: Binding<CGFloat>) -> some View {
        self.modifier(ZoomEffect(scale: scale))
    }
}
