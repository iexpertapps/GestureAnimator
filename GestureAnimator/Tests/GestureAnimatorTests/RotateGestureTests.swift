//
//  RotateGestureTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable import GestureAnimator
import SwiftUI

final class RotateGestureTests: XCTestCase {

    func testRotateViewModelGestureChange() {
        let initialAngle: Angle = Angle.degrees(0)
        let viewModel = RotateViewModel(initialAngle: initialAngle)

        viewModel.onGestureStart()
        viewModel.updateGesture(rotation: Angle.degrees(30))

        XCTAssertEqual(viewModel.angle.degrees, 30, accuracy: 0.001)
    }

    func testRotateViewModelGestureEnd() {
        let viewModel = RotateViewModel(initialAngle: Angle.degrees(15))
        let predicted = Angle.degrees(20)

        let expectation = XCTestExpectation(description: "Gesture end rotation")

        viewModel.onGestureEnd(velocity: predicted) { final in
            XCTAssertEqual(final.degrees, 35, accuracy: 0.001)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
