//
//  SpaceXTests.swift
//  SpaceXTests
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import XCTest
@testable import SpaceX

class SpaceXTests: XCTestCase {

    func data(for fileName: String) -> Data? {
        guard let filePath = Bundle(for: SpaceXTests.self).path(forResource: fileName, ofType: "json") else {
                return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
    }

    func testParsingShouldResultInExpectedObjectCount() {
        // Arrange
        guard let launchesData = data(for: "launches") else {
            XCTFail()
            return
        }
        let expectedObjectCount = 56

        // Act
        guard let content = try? JSONDecoder().decode(Launches.self, from: launchesData) else {
            XCTFail()
            return
        }

        // Assert
        XCTAssertEqual(content.launches.count, expectedObjectCount)
    }
}
