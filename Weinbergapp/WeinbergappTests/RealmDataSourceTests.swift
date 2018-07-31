//
//  RealmDataSourceTests.swift
//  WeinbergappTests
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Weinbergapp

class RealmDataSourceTests: XCTestCase {
    
    var mockedRealm: MockedRealm!
    var dataSource: RealmDataSource<TestObject>!
    
    override func setUp() {
        super.setUp()
        
        mockedRealm = MockedRealm()
        dataSource = RealmDataSource(realm: mockedRealm)
    }
    
    func testQueryAll() throws {
        // given
        let expectedObjects = [
            TestObject(),
            TestObject(),
            TestObject()
        ]
        mockedRealm.objects = expectedObjects
        
        // when
        let actualObjects = try dataSource.queryAll()
        
        // then
        XCTAssertEqual(expectedObjects, actualObjects)
    }
    
    func testAdd() throws {
        // given
        let testObject = TestObject()
        
        // when
        try dataSource.add(testObject)
        
        // then
        XCTAssertEqual(mockedRealm.objects.count, 1)
        XCTAssertEqual(mockedRealm.objects[0], testObject)
    }
    
    func testUpdate() throws {
        // given
        let testObject = TestObject()
        testObject.num = 10
        
        // when
        try dataSource.update {
            testObject.num = 20
        }
        
        // then
        XCTAssertEqual(testObject.num, 20)
    }
    
    func testDelete() throws {
        // given
        let testObject = TestObject()
        mockedRealm.objects = [testObject]
        
        // when
        try dataSource.delete(testObject)
        
        // then
        XCTAssertEqual(mockedRealm.objects.count, 0)
    }
}

class TestObject: Object {
    var num: Int = 0
}

class MockedRealm: MockableRealm {
    
    var objects: [Object] = []
    
    func queryAll<Element>(_ type: Element.Type) -> [Element] where Element : Object {
        var results: [Element] = []
        
        for object in objects {
            if let element = object as? Element {
                results.append(element)
            }
        }
        
        return results
    }
    
    func write(_ block: (() throws -> Void)) throws {
        try block()
    }
    
    func add(_ object: Object) {
        objects.append(object)
    }
    
    func delete(_ object: Object) {
        if let index = objects.index(of: object) {
            objects.remove(at: index)
        }
    }
}
