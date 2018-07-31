//
//  GermanDateFormatterTests.swift
//  WeinbergappTests
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
@testable import Weinbergapp

class GermanDateFormatterTests: XCTestCase {
    
    func testDate1() {
        // given
        let date = createDate(day: 7, month: 1, year: 1980)
        
        // when
        let formattedDate = GermanDateFormatter.shared.string(from: date)
        
        // then
        XCTAssertEqual(formattedDate, "07.01.1980")
    }
    
    func testDate2() {
        // given
        let date = createDate(day: 31, month: 7, year: 2018)
        
        // when
        let formattedDate = GermanDateFormatter.shared.string(from: date)
        
        // then
        XCTAssertEqual(formattedDate, "31.07.2018")
    }
    
    func testDate3() {
        // given
        let date = createDate(day: 24, month: 12, year: 2049)
        
        // when
        let formattedDate = GermanDateFormatter.shared.string(from: date)
        
        // then
        XCTAssertEqual(formattedDate, "24.12.2049")
    }
    
    func testString1() {
        // given
        let string = "01.08.2018"
        
        // when
        let actualDate = GermanDateFormatter.shared.date(from: string)
        let expectedDate = createDate(day: 1, month: 8, year: 2018)
        
        // then
        XCTAssertEqual(expectedDate, actualDate)
    }
    
    func testString2() {
        // given
        let string = "01.01.510"
        
        // when
        let actualDate = GermanDateFormatter.shared.date(from: string)
        let expectedDate = createDate(day: 1, month: 1, year: 510)
        
        // then
        XCTAssertEqual(expectedDate, actualDate)
    }
    
    func testString3() {
        // given
        let string = "31.13.3050"
        
        // when
        let date = GermanDateFormatter.shared.date(from: string)
        
        // then
        XCTAssertNil(date)
    }
    
    private func createDate(day: Int, month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    
}
