//
//  GestureAnimatable.swift
//  GestureAnimator
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//


import Foundation
import SwiftUI

public protocol GestureAnimatable {
    associatedtype Value: VectorArithmetic
    var value: Value { get }

    func onGestureStart()
    func onGestureChange(_ newValue: Value)
    func onGestureEnd(velocity: Value, completion: @escaping (Value) -> Void)
}
