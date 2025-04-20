//
//  ZoomGestureTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable import GestureAnimator

final class ZoomGestureTests: XCTestCase {

    func testZoomViewModelGestureChange() {
        let initialScale: CGFloat = 1.0
        let viewModel = ZoomViewModel(initialScale: initialScale)

        viewModel.onGestureStart()
        viewModel.updateGesture(scale: 1.5)

        XCTAssertEqual(viewModel.scale, 1.5, accuracy: 0.0001)
    }

    func testZoomViewModelGestureEnd() {
        let viewModel = ZoomViewModel(initialScale: 2.0)

        let expectation = XCTestExpectation(description: "Gesture end completion")

        viewModel.onGestureEnd(velocity: 1.25) { finalValue in
            XCTAssertEqual(finalValue, 2.5, accuracy: 0.0001)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

