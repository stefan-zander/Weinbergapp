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

    private var realm: Realm?

    public func queryAll() throws -> [T] {
        let realm = try getOrCreateRealm()

        return Array(realm.objects(T.self))
    }

    public func add(_ element: T) throws {
        let realm = try getOrCreateRealm()

        try realm.write {
            realm.add(element)
        }
    }

    public func update(_ block: (() throws -> Void)) throws {
        let realm = try getOrCreateRealm()

        try realm.write(block)
    }

    public func delete(_ element: T) throws {
        let realm = try getOrCreateRealm()

        try realm.write {
            realm.delete(element)
        }
    }

    private func getOrCreateRealm() throws -> Realm {
        if let realm = self.realm {
            return realm
        }

        let realm = try Realm()
        self.realm = realm
        return realm
    }
}
