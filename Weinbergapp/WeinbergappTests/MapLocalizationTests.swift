//
//  MapLocalizationTests.swift
//  WeinbergappTests
//
//  Created by VM on 01.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
@testable import Weinbergapp

class MapLocalizationTests: XCTestCase {
    
    func testZeroMeters() {
        // given
        let zeroMeters = 0.0
        
        // when
        let localized = MapLocalization.localize(area: zeroMeters)
        
        // then
        XCTAssertEqual("0 m²", localized)
    }
    
    func testTwentySquareMeters() {
        // given
        let twentyMeters = 20.0
        
        // when
        let localized = MapLocalization.localize(area: twentyMeters)
        
        // then
        XCTAssertEqual("20 m²", localized)
    }
    
    func testOneSquareKilometers() {
        // given
        let oneSquareKilometer = 1000.0 * 1000.0
        
        // when
        let localized = MapLocalization.localize(area: oneSquareKilometer)
        
        // then
        XCTAssertEqual("1.00 km²", localized)
    }
    
    func testOneAndAQuarterSquareKilometers() {
        // given
        let oneAndAQuarterSquareKilometer = 1000.0 * 1000.0 * 1.25
        
        // when
        let localized = MapLocalization.localize(area: oneAndAQuarterSquareKilometer)
        
        // then
        XCTAssertEqual("1.25 km²", localized)
    }
    
    func testMinusFiveHundredSquareKilometers() {
        // given
        let oneSquareKilometer = -500.0 * 1000.0 * 1000.0
        
        // when
        let localized = MapLocalization.localize(area: oneSquareKilometer)
        
        // then
        XCTAssertEqual("-500.00 km²", localized)
    }
}
