//
//  RotateViewModel.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import SwiftUI

public final class RotateViewModel: ObservableObject {
    @Published public var angle: Angle = .degrees(0)
    private var initialAngle: Angle = .degrees(0)

    public init(initialAngle: Angle = .degrees(0)) {
        self.initialAngle = initialAngle
        self.angle = initialAngle
    }

    public func onGestureStart() {
        initialAngle = angle
    }

    public func updateGesture(rotation: Angle) {
        angle = Angle(degrees: initialAngle.degrees + rotation.degrees)
    }

    public func reset() {
        angle = .degrees(0)
    }

    public func onGestureEnd(velocity: Angle, completion: @escaping (Angle) -> Void) {
        let final = Angle(degrees: angle.degrees + velocity.degrees)
        completion(final)
    }
}
