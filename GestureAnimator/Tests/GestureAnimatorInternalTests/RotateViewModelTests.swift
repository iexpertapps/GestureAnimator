//
//  RotateViewModelTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable @_spi(GestureAnimatorInternal) import GestureAnimator

final class RotateViewModelTests: XCTestCase {
    
    var viewModel: RotateViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RotateViewModel()
    }

    func testInitialAngle() {
        XCTAssertEqual(viewModel.angle, .zero, "Initial angle should be zero")
    }

    func testOnGestureStart() {
        viewModel.angle = .degrees(45)
        viewModel.onGestureStart()
        XCTAssertEqual(viewModel.angle, .degrees(45), "Angle should be preserved on gesture start")
    }

    func testUpdateGesture() {
        viewModel.angle = .zero
        viewModel.updateGesture(rotation: .degrees(90))
        XCTAssertEqual(viewModel.angle, .degrees(90), "Angle should be updated correctly with rotation")
    }

    func testReset() {
        viewModel.angle = .degrees(45)
        viewModel.reset()
        XCTAssertEqual(viewModel.angle, .zero, "Angle should reset to zero")
    }
}
