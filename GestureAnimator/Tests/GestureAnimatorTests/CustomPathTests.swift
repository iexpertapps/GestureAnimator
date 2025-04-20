//
//  CustomPathTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable import GestureAnimator

final class CustomPathTests: XCTestCase {

    func testCustomPathProgressChange() {
        let viewModel = CustomPathViewModel(initialProgress: 0.2)
        viewModel.onGestureChange(0.3)
        XCTAssertEqual(viewModel.value, 0.5, accuracy: 0.001)
    }

    func testCustomPathClamping() {
        let viewModel = CustomPathViewModel(initialProgress: 0.95)
        viewModel.onGestureChange(0.2)
        XCTAssertEqual(viewModel.value, 1.0, accuracy: 0.001)

        viewModel.onGestureChange(-1.5)
        XCTAssertEqual(viewModel.value, 0.0, accuracy: 0.001)
    }

    func testCustomPathGestureEnd() {
        let viewModel = CustomPathViewModel(initialProgress: 0.6)
        let expectation = XCTestExpectation(description: "Custom path gesture ends")

        viewModel.onGestureEnd(velocity: 0.5) { final in
            XCTAssertEqual(final, 1.0, accuracy: 0.001)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
