//
//  CustomPathViewModelTests.swift
//  GestureAnimatorTests
//
//  Created by Syed Zia ur Rehman on 19/04/2025.
//

import XCTest
@testable @_spi(GestureAnimatorInternal) import GestureAnimator

final class CustomPathViewModelTests: XCTestCase {
    
    var viewModel: CustomPathViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CustomPathViewModel()
    }

    func testInitialPath() {
        XCTAssertTrue(viewModel.currentPath.isEmpty, "Initial path should be empty")
    }

    func testAddPoint() {
        let point = CGPoint(x: 50, y: 50)
        viewModel.addPoint(point)
        XCTAssertFalse(viewModel.currentPath.isEmpty, "Path should contain points after adding a point")
    }

    func testReset() {
        let point = CGPoint(x: 50, y: 50)
        viewModel.addPoint(point)
        viewModel.reset()
        XCTAssertTrue(viewModel.currentPath.isEmpty, "Path should be reset to empty")
    }
}
