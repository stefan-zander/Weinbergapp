//
//  RealmDataSource.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 29.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmDataSource<T: Object> {

    private var realm: MockableRealm
    
    init(realm: MockableRealm) {
        self.realm = realm
    }

    public func queryAll() throws -> [T] {
        return Array(realm.objects(T.self))
    }

    public func add(_ element: T) throws {
        try realm.write {
            realm.add(element)
        }
    }

    public func update(_ block: (() throws -> Void)) throws {
        try realm.write(block)
    }

    public func delete(_ element: T) throws {
        try realm.write {
            realm.delete(element)
        }
    }
}
