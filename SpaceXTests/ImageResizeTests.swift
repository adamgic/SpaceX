//
//  ImageResizeTests.swift
//  SpaceXTests
//
//  Created by Recsio on 10/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import XCTest
@testable import SpaceX

class ImageResizeTests: XCTestCase {

    class TestImage: UIImage {
        var inputSize: CGSize = .zero
        override var size: CGSize {
            return inputSize
        }
    }

    let image = TestImage()
    let desiredSize = CGSize(width: 120, height: 120)

    func testResizeImageWithEqualRatio() {
        // Arrange
        let inputSize = CGSize(width: 250, height: 250)
        let expectedSize = desiredSize
        image.inputSize = inputSize

        // Act
        let resultingSize = image.size(thatFits: desiredSize)

        // Assert
        XCTAssertEqual(resultingSize, expectedSize)
    }

    func testResizeImageWithGreaterRatio() {
        // Arrange
        let inputSize = CGSize(width: 360, height: 300)
        let expectedSize = CGSize(width: 120, height: 100)
        image.inputSize = inputSize

        // Act
        let resultingSize = image.size(thatFits: desiredSize)

        // Assert
        XCTAssertEqual(resultingSize, expectedSize)
    }

    func testResizeImageWithSmallerRatio() {
        // Arrange
        let inputSize = CGSize(width: 500, height: 600)
        let expectedSize = CGSize(width: 100, height: 120)
        image.inputSize = inputSize

        // Act
        let resultingSize = image.size(thatFits: desiredSize)

        // Assert
        XCTAssertEqual(resultingSize, expectedSize)
    }
}
