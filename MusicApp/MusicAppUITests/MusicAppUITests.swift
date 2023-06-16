//
//  MusicAppUITests.swift
//  MusicAppUITests
//
//  Created by Emine Sinem on 6.06.2023.
//

import XCTest

final class MusicAppUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("******** UITest ********")
    }

    
    func test_go_to_detail() {
        app.launch()
        sleep(4)
        XCTAssertTrue(app.navigationBars["iTunes Search"].exists)
        app.tables.searchFields["Search"].tap()
        XCTAssertTrue(app.searchFields["Search"].exists)
        app.searchFields["Search"].typeText("Selena")
        app.collectionViews["collectionView"].cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.collectionViews["collectionView"].exists)
    }
}
