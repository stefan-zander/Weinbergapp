//
//  MapViewControllerTests.swift
//  WeinbergappUITests
//
//  Created by VM on 03.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest

class MapViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testAddAndRemovePolygon() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText("user")
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText("weinberg")
        
        app.buttons["Anmelden"].tap()
        
        // when
        app.navigationBars.buttons["Add"].tap()
        
        app.otherElements["Freiburg"].press(forDuration: 0.5)
        app.otherElements["Stuttgart"].press(forDuration: 0.5)
        app.otherElements["Augsburg"].press(forDuration: 0.5)
        
        app.navigationBars.buttons["Done"].tap()

        app.textFields["fieldName"].tap()
        app.textFields["fieldName"].typeText("Field 1")
        
        app.textFields["fieldVineVariety"].tap()
        app.textFields["fieldVineVariety"].typeText("Vine Variety 1")
        
        app.navigationBars.buttons["Save"].tap()
        
        let field1 = app.otherElements["Field 1 (7676.23 km²), Reben Sorte: Vine Variety 1"]
        let field1Existed = field1.exists
        
        field1.tap()
        usleep(1000000)
        app.buttons["More Info"].tap()
        usleep(1000000)
        app.buttons["Fläche löschen"].tap()
        
        // then
        XCTAssertTrue(field1Existed)
        XCTAssertFalse(field1.exists)
    }
    
}
