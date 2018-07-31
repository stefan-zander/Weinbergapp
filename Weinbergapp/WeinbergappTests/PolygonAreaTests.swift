//
//  PolygonAreaTests.swift
//  WeinbergappTests
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weinbergapp

class PolygonAreaTests: XCTestCase {

    func testRadians1() {
        // given
        let degrees = 90.0

        // when
        let actualRadians = radians(degrees: degrees)
        let expectedRadians = Double.pi / 2

        // then
        XCTAssertEqual(expectedRadians, actualRadians, accuracy: 1e-10)
    }

    func testRadians2() {
        // given
        let degrees = 360.0

        // when
        let actualRadians = radians(degrees: degrees)
        let expectedRadians = 2 * Double.pi

        // then
        XCTAssertEqual(expectedRadians, actualRadians, accuracy: 1e-10)
    }

    func testDegrees1() {
        // given
        let radians = 0.0

        // when
        let actualDegrees = degrees(radians: radians)
        let expectedDegrees = 0.0

        // then
        XCTAssertEqual(expectedDegrees, actualDegrees, accuracy: 1e-10)
    }

    func testDegrees2() {
        // given
        let radians = 4 * Double.pi

        // when
        let actualDegrees = degrees(radians: radians)
        let expectedDegrees = 2 * 360.0

        // then
        XCTAssertEqual(expectedDegrees, actualDegrees, accuracy: 1e-10)
    }

    func testComputeAreaEmpty() {
        // given
        let polygon = [
            CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        ]

        // when
        let actualArea = computeArea(coordinates: polygon)

        // then
        XCTAssertEqual(actualArea, 0.0, accuracy: 1e-10)
    }

    func testComputeAreaEiffleTower() {
        // given
        
        // Source: Coordinates of vertices of the eiffle tower were obtained from MapKit
        let eiffleTower = [
            CLLocationCoordinate2D(latitude: 48.859051240203826, longitude: 2.294493716281107),
            CLLocationCoordinate2D(latitude: 48.858282385487286, longitude: 2.2957060566096268),
            CLLocationCoordinate2D(latitude: 48.857463830025296, longitude: 2.2945175656281482),
            CLLocationCoordinate2D(latitude: 48.858248388220119, longitude: 2.2932913134106578)
        ]
        
        // when

        // Source: https://www.wonders-of-the-world.net/Eiffel-Tower/Dimensions-of-the-Eiffel-tower.php
        let widthOfEiffleTowerInMeters = 125.0
        let surfaceOfEiffleTowerInSquareMeters = widthOfEiffleTowerInMeters * widthOfEiffleTowerInMeters
        let computedAreaInSquareMeters = computeArea(coordinates: eiffleTower)

        // then
        XCTAssertEqual(computedAreaInSquareMeters,
                       surfaceOfEiffleTowerInSquareMeters,
                       accuracy: 10.0) // 10 square meter accuracy
    }
}
