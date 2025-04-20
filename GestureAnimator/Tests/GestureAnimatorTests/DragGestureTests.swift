//
//  DragGestureTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
import SwiftUI
@testable import GestureAnimator // Assuming your package name

final class DragGestureTests: XCTestCase {

    func testDragViewModelGestureChange() {
        let initialOffset = CGSize(width: 0, height: 0)
        let viewModel = DragViewModel(initialOffset: initialOffset)

        viewModel.onGestureStart()  // Initialize the start of the gesture
        
        // Update the offset with a new translation (simulating a drag gesture)
        viewModel.updateGesture(translation: CGSize(width: 20, height: 15))

        // Assert that the offset has been updated correctly
        XCTAssertEqual(viewModel.offset.width, 20, accuracy: 0.001)
        XCTAssertEqual(viewModel.offset.height, 15, accuracy: 0.001)
    }

    func testDragViewModelGestureEnd() {
        let initialOffset = CGSize(width: 10, height: 10)
        let viewModel = DragViewModel(initialOffset: initialOffset)
        
        let predictedVelocity = CGSize(width: 30, height: 20)
        
        let expectation = XCTestExpectation(description: "Gesture end with drag offset")

        viewModel.onGestureEnd(velocity: predictedVelocity) { final in
            // Assuming predicted velocity will update the final offset:
            XCTAssertEqual(final.width, 40, accuracy: 0.001) // 10 initial + 30 velocity
            XCTAssertEqual(final.height, 30, accuracy: 0.001) // 10 initial + 20 velocity
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

