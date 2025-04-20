//
//  DragViewModelTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable @_spi(GestureAnimatorInternal) import GestureAnimator
import Foundation

final class DragViewModelTests: XCTestCase {
    
    var viewModel: DragViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = DragViewModel()
    }

    func testInitialOffset() {
        XCTAssertEqual(viewModel.offset, .zero, "Initial offset should be zero")
    }

    func testOnGestureStart() {
        viewModel.offset = CGSize(width: 100, height: 100)
        viewModel.onGestureStart()
        XCTAssertEqual(viewModel.offset, CGSize(width: 100, height: 100), "Initial offset should be preserved")
    }

    func testUpdateGesture() {
        viewModel.offset = CGSize(width: 0, height: 0)
        viewModel.updateGesture(translation: CGSize(width: 50, height: 50))
        XCTAssertEqual(viewModel.offset, CGSize(width: 50, height: 50), "Offset should update with translation")
    }

    func testReset() {
        viewModel.offset = CGSize(width: 100, height: 100)
        viewModel.reset()
        XCTAssertEqual(viewModel.offset, .zero, "Offset should reset to zero")
    }
}
