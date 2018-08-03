//
//  FertilizationViewControllerTests.swift
//  WeinbergappUITests
//
//  Created by VM on 03.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest

class FertilizationViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testAdd() {
        let app = XCUIApplication()
        
        app.textFields["Benutzername"].tap()
        app.textFields["Benutzername"].typeText(LoginViewControllerTests.kUsername)
        
        app.secureTextFields["Passwort"].tap()
        app.secureTextFields["Passwort"].typeText(LoginViewControllerTests.kPassword)
        
        app.buttons["Anmelden"].tap()
        
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
        
        app.tabBars.buttons["Arbeitsgänge"].tap()
        app.tables.staticTexts["Düngung"].tap()
        app.navigationBars.buttons["Add"].tap()
        
        let scrollView = app.scrollViews.otherElements
        
        let user = scrollView.textFields["Benutzer eintragen..."]
        user.tap()
        user.typeText("User 1")
        
        let workingHours = scrollView.textFields["Arbeitsstunden eintragen..."]
        workingHours.tap()
        workingHours.typeText("40")
        
        let fertilizierCategory = scrollView.pickerWheels["Mineralisch"]
        fertilizierCategory.tap()
        fertilizierCategory.adjust(toPickerWheelValue: "Organisch")
        
        let fertilizier = scrollView.pickerWheels["Terragon"]
        fertilizier.tap()
        fertilizier.adjust(toPickerWheelValue: "Trester")
        
        let appliedAmount = scrollView.textFields["Ausgebrachte Menge eintragen..."]
        appliedAmount.tap()
        appliedAmount.typeText("10")
        
        app.navigationBars.buttons["Save"].tap()
        
        let cellCountAfterAdding = app.tables.element.cells.count
        let fieldExisted = app.tables.staticTexts["Feld: Field 1"].exists
        let userExisted = app.tables.staticTexts["Benutzer: User 1"].exists
        
        app.tables.cells.element(boundBy: 0).swipeLeft()
        app.tables.cells.element(boundBy: 0).buttons["Delete"].tap()
        
        let cellCountAfterDeletion = app.tables.element.cells.count
        
        app.navigationBars.buttons["Zurück"].tap()
        
        app.tabBars.buttons["Karte"].tap()
        
        app.otherElements["Field 1 (7676.23 km²), Reben Sorte: Vine Variety 1"].tap()
        
        app.buttons["More Info"].tap()
        app.buttons["Fläche löschen"].tap()
        app.alerts["Löschvorgang bestätigen"].buttons["Ja, \"Field 1\" löschen"].tap()
        
        XCTAssertEqual(cellCountAfterAdding, 1)
        XCTAssertEqual(cellCountAfterDeletion, 0)
        XCTAssertTrue(fieldExisted)
        XCTAssertTrue(userExisted)
    }    
}
