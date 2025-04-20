//
//  MorphViewModelTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable @_spi(GestureAnimatorInternal) import GestureAnimator

final class MorphViewModelTests: XCTestCase {
    
    var viewModel: MorphViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MorphViewModel()
    }

    func testInitialProgress() {
        XCTAssertEqual(viewModel.progress, 0.0, "Initial progress should be 0.0")
    }

    func testUpdateGesture() {
        viewModel.updateGesture(translation: 0.5)
        XCTAssertEqual(viewModel.progress, 0.5, "Progress should update with translation")
    }

    func testClampProgress() {
        viewModel.updateGesture(translation: 1.5)
        XCTAssertEqual(viewModel.progress, 1.0, "Progress should clamp to a maximum of 1.0")
        
        viewModel.updateGesture(translation: -0.5)
        XCTAssertEqual(viewModel.progress, 0.0, "Progress should clamp to a minimum of 0.0")
    }

    func testReset() {
        viewModel.updateGesture(translation: 0.7)
        viewModel.reset()
        XCTAssertEqual(viewModel.progress, 0.0, "Progress should reset to 0.0")
    }
}
