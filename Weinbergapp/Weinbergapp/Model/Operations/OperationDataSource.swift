//
//  OperationDataSource.swift
//  Weinbergapp
//
//  Created by VM on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

public class OperationDataSource<T: Object> {
    
    var realm: Realm?
    
    public func query(elements: inout [T]) throws {
        let realm = try self.realm ?? Realm()
        
        elements = Array(realm.objects(T.self))
    }
    
    public func createId() throws -> Int {
        let realm = try self.realm ?? Realm()
        let newId: Int? = realm.objects(T.self).max(ofProperty: "id")
        
        return (newId ?? 0) + 1
    }
    
    public func add(_ element: T) throws {
        let realm = try self.realm ?? Realm()
        
        try realm.write {
            realm.add(element)
        }
    }
    
    public func update(_ block: (() throws -> Void)) throws {
        let realm = try self.realm ?? Realm()
        try realm.write(block)
    }
    
    public func delete(_ element: T) throws {
        let realm = try self.realm ?? Realm()
        
        try realm.write {
            realm.delete(element)
        }
    }
}
