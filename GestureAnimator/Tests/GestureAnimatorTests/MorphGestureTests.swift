//
//  MorphGestureTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable import GestureAnimator

final class MorphGestureTests: XCTestCase {

    // Test for gesture progress change
    func testMorphGestureChange() {
        let viewModel = MorphViewModel(initialProgress: 0.3)
        
        // Call the method that updates progress based on the gesture translation
        viewModel.updateGesture(translation: 0.4)

        // Assert the expected progress after change
        XCTAssertEqual(viewModel.progress, 0.7, accuracy: 0.001)
    }

    // Test for clamping of the progress value
    func testMorphGestureClamping() {
        let viewModel = MorphViewModel(initialProgress: 0.95)
        
        // Gesture change that exceeds the upper bound of 1
        viewModel.updateGesture(translation: 0.2)
        XCTAssertEqual(viewModel.progress, 1.0, accuracy: 0.001)

        // Gesture change that exceeds the lower bound of 0
        viewModel.updateGesture(translation: -1.5)
        XCTAssertEqual(viewModel.progress, 0.0, accuracy: 0.001)
    }

    // Test for gesture end completion
    func testMorphGestureEnd() {
        let viewModel = MorphViewModel(initialProgress: 0.5)
        let expectation = XCTestExpectation(description: "Morph end completion")

        // Call onGestureEnd to simulate the end of a gesture
        viewModel.onGestureEnd(velocity: 0.6) { result in
            XCTAssertEqual(result, 1.0, accuracy: 0.001)  // Expected result after velocity is applied
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
