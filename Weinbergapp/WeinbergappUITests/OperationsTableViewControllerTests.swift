//
//  OperationsTableViewControllerTests.swift
//  WeinbergappUITests
//
//  Created by VM on 03.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest

class OperationsTableViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testFertilizationNoFields() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText(LoginViewControllerTests.kUsername)
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText(LoginViewControllerTests.kPassword)
        
        app.buttons["Anmelden"].tap()
        
        app.tabBars.buttons["Arbeitsgänge"].tap()
        
        // when
        app.tables.staticTexts["Düngung"].tap()
        
        let alert = app.alerts["Keine Felder vorhanden"]
        
        // then
        XCTAssertTrue(alert.exists)
    }
    
    func testDefoliationNoFields() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText(LoginViewControllerTests.kUsername)
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText(LoginViewControllerTests.kPassword)
        
        app.buttons["Anmelden"].tap()
        
        app.tabBars.buttons["Arbeitsgänge"].tap()
        
        // when
        app.tables.staticTexts["Entlauben"].tap()
        
        let alert = app.alerts["Keine Felder vorhanden"]
        
        // then
        XCTAssertTrue(alert.exists)
    }
    
    func testPlantProtectionNoFields() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText(LoginViewControllerTests.kUsername)
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText(LoginViewControllerTests.kPassword)
        
        app.buttons["Anmelden"].tap()
        
        app.tabBars.buttons["Arbeitsgänge"].tap()
        
        // when
        app.tables.staticTexts["Pflanzenschutz"].tap()
        
        let alert = app.alerts["Keine Felder vorhanden"]
        
        // then
        XCTAssertTrue(alert.exists)
    }
    
    func testVintageNoFields() {
        // given
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText(LoginViewControllerTests.kUsername)
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText(LoginViewControllerTests.kPassword)
        
        app.buttons["Anmelden"].tap()
        
        app.tabBars.buttons["Arbeitsgänge"].tap()
        
        // when
        app.tables.staticTexts["Traubenlese"].tap()
        
        let alert = app.alerts["Keine Felder vorhanden"]
        
        // then
        XCTAssertTrue(alert.exists)
    }
    
}
