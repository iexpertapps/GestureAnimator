//
//  CustomPathViewModel.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI

public final class CustomPathViewModel: ObservableObject {
    
    @Published public var value: CGFloat
    
    // Initialize with an optional progress value for flexibility.
   public init(initialProgress: CGFloat = 0.0) {
        self.value = initialProgress
    }

    // Called when the gesture is changing, update value based on translation.
    public func onGestureChange(_ translation: CGFloat) {
        value = min(max(value + translation, 0.0), 1.0) // Clamps to [0, 1]
    }

    // Called when the gesture ends, with optional velocity handling.
    public func onGestureEnd(velocity: CGFloat, completion: @escaping (CGFloat) -> Void) {
        // Simulate the gesture end logic using the velocity.
        let finalValue = min(max(value + velocity, 0.0), 1.0)
        completion(finalValue)
    }
}





