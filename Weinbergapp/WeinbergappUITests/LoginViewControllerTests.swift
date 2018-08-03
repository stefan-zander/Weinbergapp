//
//  WeinbergappUITests.swift
//  WeinbergappUITests
//
//  Created by Stefan Zander on 08.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest

class LoginViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testTogglingPasswordVisibility() {
        // given
        let app = XCUIApplication()
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText("wrong")
        
        // when
        app.switches.element.tap()
        
        // then
        XCTAssertTrue(app.textFields["Passwort"].exists)
    }
    
    func testTogglingPasswordVisibility2() {
        // given
        let app = XCUIApplication()
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText("wrong")
        
        // when
        app.switches.element.tap()
        app.switches.element.tap()
        
        // then
        XCTAssertTrue(app.secureTextFields["Passwort"].exists)
    }

    func testInvalidCredentialsDialog() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText("wrong")
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText("wrong")
        
        // when
        app.buttons["Anmelden"].tap()
        let loginFehlgeschlagenAlert = app.alerts["Login fehlgeschlagen"]
        
        // then
        XCTAssertTrue(loginFehlgeschlagenAlert.exists)
    }
    
    func testValidCredentialsDialog() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText("user")
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText("weinberg")
        
        // when
        app.buttons["Anmelden"].tap()
        
        // then
        XCTAssertTrue(app.tabBars.buttons["Karte"].exists)
    }
}
