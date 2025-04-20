//
//  MorphViewModel.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI


public final class MorphViewModel: ObservableObject {
    @Published public var progress: CGFloat = 0.0

    // Initialize with an optional progress value for more flexibility.
    public init(initialProgress: CGFloat = 0.0) {
        self.progress = initialProgress
    }

    // Updates the progress based on the gesture translation value.
    public func updateGesture(translation: CGFloat) {
        progress = min(max(translation, 0), 1)  // Clamp to the 0-1 range.
    }

    // Resets the progress to 0 (useful for canceling or starting over).
    public func reset() {
        progress = 0.0
    }

    // Handles the end of the gesture, optionally with velocity for smooth transitions.
    public func onGestureEnd(velocity: CGFloat, completion: @escaping (CGFloat) -> Void) {
        let finalProgress = min(max(progress + velocity, 0), 1)
        completion(finalProgress)
    }
}
