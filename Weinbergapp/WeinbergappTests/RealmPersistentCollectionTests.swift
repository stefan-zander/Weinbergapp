//
//  RealmPersistentCollectionTests.swift
//  WeinbergappTests
//
//  Created by VM on 01.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Weinbergapp

class RealmPersistentCollectionTests: XCTestCase {
    
    var mockedRealm: MockedRealm!
    var collection: RealmPersistentCollection<TestObject>!
    
    override func setUp() {
        super.setUp()
        
        mockedRealm = MockedRealm()
        collection = RealmPersistentCollection(realm: mockedRealm)
    }
    
    func testInit() {
        // given
        let expected = TestObject()
        mockedRealm.objects = [expected]
        
        // when
        collection = RealmPersistentCollection(realm: mockedRealm)
        
        // then
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(expected, collection[0])
    }
    
    func testAdd() throws {
        // given
        let expected = TestObject()
        
        // when
        try collection.add(expected)
        
        // then
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(expected, collection[0])
        XCTAssertEqual(mockedRealm.objects.count, 1)
        XCTAssertEqual(expected, mockedRealm.objects[0])
    }
    
    func testAdd2() throws {
        // given
        let testObjects = [
            TestObject(),
            TestObject(),
            TestObject()
        ]
        
        // when
        for object in testObjects {
            try collection.add(object)
        }
        
        // then
        XCTAssertEqual(testObjects.count, collection.count)
        for i in 0..<testObjects.count {
            XCTAssertEqual(testObjects[i], collection[i])
        }
        
        XCTAssertEqual(testObjects.count, mockedRealm.objects.count)
        for i in 0..<testObjects.count {
            XCTAssertEqual(testObjects[i], mockedRealm.objects[i])
        }
    }
    
    func testUpdate() throws {
        // given
        let testObject = TestObject()
        testObject.num = 10
        try collection.add(testObject)
        
        // when
        try collection.update {
            testObject.num = 20
        }
        
        // then
        XCTAssertEqual(collection[0].num, 20)
        XCTAssertEqual((mockedRealm.objects[0] as! TestObject).num, 20)
        XCTAssertEqual(testObject.num, 20)
    }
    
    func testDelete() throws {
        // given
        let testObject = TestObject()
        try collection.add(testObject)
        
        // when
        try collection.delete(testObject)
        
        // then
        XCTAssertEqual(collection.count, 0)
        XCTAssertEqual(mockedRealm.objects.count, 0)
    }
    
    func testDelete2() throws {
        // given
        let testObject = TestObject()
        let differentTestObject = TestObject()
        
        try collection.add(testObject)
        
        // when
        try collection.delete(differentTestObject)
        
        // then
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(testObject, collection[0])
        XCTAssertEqual(mockedRealm.objects.count, 1)
        XCTAssertEqual(testObject, mockedRealm.objects[0])
    }
    
    func testDelete3() throws {
        let testObject1 = TestObject()
        let testObject2 = TestObject()
        let testObject3 = TestObject()
        try collection.add(testObject1)
        try collection.add(testObject2)
        try collection.add(testObject3)
        
        // when
        try collection.delete(at: 1)
        
        // then
        XCTAssertEqual(collection.count, 2)
        XCTAssertEqual(testObject1, collection[0])
        XCTAssertEqual(testObject3, collection[1])
        XCTAssertEqual(mockedRealm.objects.count, 2)
        XCTAssertEqual(testObject1, mockedRealm.objects[0])
        XCTAssertEqual(testObject3, mockedRealm.objects[1])
    }
    
}
