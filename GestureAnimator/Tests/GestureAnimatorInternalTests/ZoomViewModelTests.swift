//
//  ZoomViewModelTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable @_spi(GestureAnimatorInternal) import GestureAnimator

final class ZoomViewModelTests: XCTestCase {
    
    var viewModel: ZoomViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ZoomViewModel()
    }

    func testInitialScale() {
        XCTAssertEqual(viewModel.scale, 1.0, "Initial scale should be 1.0")
    }

    func testOnGestureStart() {
        viewModel.scale = 2.0
        viewModel.onGestureStart()
        XCTAssertEqual(viewModel.scale, 2.0, "On gesture start, the scale should be preserved")
    }

    func testUpdateGesture() {
        viewModel.scale = 1.0
        viewModel.updateGesture(scale: 2.0)
        XCTAssertEqual(viewModel.scale, 2.0, "Scale should be updated correctly")
    }

    func testReset() {
        viewModel.scale = 2.0
        viewModel.reset()
        XCTAssertEqual(viewModel.scale, 1.0, "Reset should return scale to 1.0")
    }
}
