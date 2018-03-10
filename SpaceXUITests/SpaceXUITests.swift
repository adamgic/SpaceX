//
//  SpaceXUITests.swift
//  SpaceXUITests
//
//  Created by Recsio on 06/03/2018.
//  Copyright © 2018 Recsio. All rights reserved.
//

import XCTest

class SpaceXUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testUseFilterScrollDownGoToDetailsGoBack() {

        // wait for test application to start
        guard XCUIApplication().switches.firstMatch.waitForExistence(timeout: 60) else {
            XCTFail()
            return
        }

        // hide successful lauches filter
        XCUIApplication().switches.firstMatch.tap()

        // hide failed lauches filter
        XCUIApplication().switches.element(boundBy: 1).tap()

        // show successful lauches filter
        XCUIApplication().switches.firstMatch.tap()


        // swipe up half of the table height
        let swipeStart = XCUIApplication().tables.element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let swipeEnd = XCUIApplication().tables.element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0))
        swipeStart.press(forDuration: 0.01, thenDragTo: swipeEnd)

        // tap some cell near the top of the table
        let topCellLocation = XCUIApplication().tables.element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        topCellLocation.tap()

        // open article link
        XCUIApplication().buttons["article link"].tap()

        // close web browser
        XCUIApplication().buttons["Done"].tap()

        // go back to launches list
        XCUIApplication().buttons["Back"].tap()

    }
}
