//
//  ZoomViewModel.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

#if canImport(SwiftUI)
import SwiftUI
#endif


public final class ZoomViewModel: ObservableObject {
    @Published public var scale: CGFloat = 1.0
    private var initialScale: CGFloat = 1.0

    public init(initialScale: CGFloat = 1.0) {
        self.initialScale = initialScale
        self.scale = initialScale
    }

    public func onGestureStart() {
        initialScale = scale
    }

    public func updateGesture(scale newScale: CGFloat) {
        scale = initialScale * newScale
    }

    public func reset() {
        scale = 1.0
    }

    public func onGestureEnd(velocity: CGFloat, completion: @escaping (CGFloat) -> Void) {
        let final = scale + velocity
        completion(final)
    }
}
