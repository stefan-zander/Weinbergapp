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
        XCTAssertEqual(localized, "0 m²")
    }

    func testTwentySquareMeters() {
        // given
        let twentyMeters = 20.0

        // when
        let localized = MapLocalization.localize(area: twentyMeters)

        // then
        XCTAssertEqual(localized, "20 m²")
    }

    func testOneSquareKilometers() {
        // given
        let oneSquareKilometer = 1000.0 * 1000.0

        // when
        let localized = MapLocalization.localize(area: oneSquareKilometer)

        // then
        XCTAssertEqual(localized, "1.00 km²")
    }

    func testOneAndAQuarterSquareKilometers() {
        // given
        let oneAndAQuarterSquareKilometer = 1000.0 * 1000.0 * 1.25

        // when
        let localized = MapLocalization.localize(area: oneAndAQuarterSquareKilometer)

        // then
        XCTAssertEqual(localized, "1.25 km²")
    }

    func testMinusFiveHundredSquareKilometers() {
        // given
        let oneSquareKilometer = -500.0 * 1000.0 * 1000.0

        // when
        let localized = MapLocalization.localize(area: oneSquareKilometer)

        // then
        XCTAssertEqual(localized, "-500.00 km²")
    }
}
