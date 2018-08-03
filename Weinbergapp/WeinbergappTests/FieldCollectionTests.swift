//
//  FieldCollectionTests.swift
//  WeinbergappTests
//
//  Created by VM on 03.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
@testable import Weinbergapp

class FieldCollectionTests: XCTestCase {

    var mockedRealm: MockedRealm!
    var collection: FieldCollection!

    override func setUp() {
        super.setUp()

        mockedRealm = MockedRealm()
        collection = FieldCollection(realm: mockedRealm)
    }

    func testInit() {
        // given
        let expected = Field()
        mockedRealm.objects = [expected]

        // when
        collection = FieldCollection(realm: mockedRealm)

        // then
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(expected, collection[0])
    }

    func testIndex1() {
        // given
        let field = Field()

        // when
        let index = collection.index(of: field)

        // then
        XCTAssertEqual(index, nil)
    }

    func testIndex2() throws {
        // given
        let field = Field()
        try collection.add(field)

        // when
        let index = collection.index(of: field)

        // then
        XCTAssertEqual(index, 0)
    }

    func testIndex3() throws {
        // given
        let field1 = Field()
        let field2 = Field()
        let field3 = Field()

        try collection.add(field1)
        try collection.add(field2)
        try collection.add(field3)

        // when
        let index1 = collection.index(of: field1)
        let index2 = collection.index(of: field2)
        let index3 = collection.index(of: field3)

        // then
        XCTAssertEqual(index1, 0)
        XCTAssertEqual(index2, 1)
        XCTAssertEqual(index3, 2)
    }

    func testIndex4() throws {
        // given
        let field1 = Field()
        let field2 = Field()
        let field3 = Field()
        let field4 = Field()

        try collection.add(field1)
        try collection.add(field2)
        try collection.add(field3)
        try collection.delete(field1)
        try collection.delete(field3)

        // when
        let index1 = collection.index(of: field1)
        let index2 = collection.index(of: field2)
        let index3 = collection.index(of: field3)
        let index4 = collection.index(of: field4)

        // then
        XCTAssertEqual(index1, nil)
        XCTAssertEqual(index2, 0)
        XCTAssertEqual(index3, nil)
        XCTAssertEqual(index4, nil)
    }

    func testAdd() throws {
        // given
        let expected = Field()

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
        let fields = [
            Field(),
            Field(),
            Field()
        ]

        // when
        for object in fields {
            try collection.add(object)
        }

        // then
        XCTAssertEqual(fields.count, collection.count)
        for i in 0..<fields.count {
            XCTAssertEqual(fields[i], collection[i])
        }

        XCTAssertEqual(fields.count, mockedRealm.objects.count)
        for i in 0..<fields.count {
            XCTAssertEqual(fields[i], mockedRealm.objects[i])
        }
    }

    func testUpdate() throws {
        // given
        let field = Field()
        field.name = "Field 1"
        field.vineVariety = "Vine Variety 1"
        field.rawCoordinates.append(objectsIn: [ 1.0, 2.0, 3.0, 4.0, 5.0, 6.0 ])
        try collection.add(field)

        // when
        try collection.update {
            field.name = "Field 2"
            field.vineVariety = "Vine Variety 2"
            field.rawCoordinates.replaceSubrange(0..<6, with: [ 2.0, 4.0, 6.0, 8.0, 10.0, 12.0 ])
        }

        // then
        let fieldInCollection = collection[0]

        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(fieldInCollection.name, "Field 2")
        XCTAssertEqual(fieldInCollection.vineVariety, "Vine Variety 2")
        XCTAssertTrue(fieldInCollection.rawCoordinates.elementsEqual([ 2.0, 4.0, 6.0, 8.0, 10.0, 12.0 ]))

        let fieldInDatabase = mockedRealm.objects[0] as! Field

        XCTAssertEqual(mockedRealm.objects.count, 1)
        XCTAssertEqual(fieldInDatabase.name, "Field 2")
        XCTAssertEqual(fieldInDatabase.vineVariety, "Vine Variety 2")
        XCTAssertTrue(fieldInDatabase.rawCoordinates.elementsEqual([ 2.0, 4.0, 6.0, 8.0, 10.0, 12.0 ]))
    }

    func testDelete() throws {
        // given
        let field = Field()
        try collection.add(field)

        // when
        try collection.delete(field)

        // then
        XCTAssertEqual(collection.count, 0)
        XCTAssertEqual(mockedRealm.objects.count, 0)
    }

    func testDelete2() throws {
        // given
        let field = Field()
        let differentField = Field()

        try collection.add(field)

        // when
        try collection.delete(differentField)

        // then
        XCTAssertEqual(collection.count, 1)
        XCTAssertEqual(field, collection[0])

        XCTAssertEqual(mockedRealm.objects.count, 1)
        XCTAssertEqual(field, mockedRealm.objects[0])
    }

    func testDelete3() throws {
        let field1 = Field()
        let field2 = Field()
        let field3 = Field()

        try collection.add(field1)
        try collection.add(field2)
        try collection.add(field3)

        // when
        try collection.delete(field2)

        // then
        XCTAssertEqual(collection.count, 2)
        XCTAssertEqual(field1, collection[0])
        XCTAssertEqual(field3, collection[1])

        XCTAssertEqual(mockedRealm.objects.count, 2)
        XCTAssertEqual(field1, mockedRealm.objects[0])
        XCTAssertEqual(field3, mockedRealm.objects[1])
    }
}
