//
//  DragViewModel.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import Foundation
import SwiftUI


public final class DragViewModel: ObservableObject {
    @Published public var offset: CGSize = .zero
    private var initialOffset: CGSize = .zero

    // Initializer to set initial offset
    public init(initialOffset: CGSize = .zero) {
        self.initialOffset = initialOffset
        self.offset = initialOffset
    }

    // This method will handle the gesture start (can reset initial offset)
    
    public func onGestureStart() {
        initialOffset = offset
    }

    // This method updates the offset as the user drags
    
    public func updateGesture(translation: CGSize) {
        offset = CGSize(width: initialOffset.width + translation.width,
                        height: initialOffset.height + translation.height)
    }

    // This method will reset the offset to the initial state
    
    public func reset() {
        offset = .zero
    }

    // This method can handle gesture end, for example, to update final state after a drag ends
    
    public func onGestureEnd(velocity: CGSize, completion: @escaping (CGSize) -> Void) {
        // For now, let's just complete with the final offset
        completion(offset)
    }
}
