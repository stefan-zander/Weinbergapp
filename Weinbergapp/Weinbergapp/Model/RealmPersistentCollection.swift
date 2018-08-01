//
//  RealmPersistentCollection.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 30.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Provides a collection of elements that is persisted within the Realm Swift database
 */
public class RealmPersistentCollection<T: Object> {

    private let realm: MockableRealm
    private var collection: [T]
    
    /**
     Creates a new `RealmPersistentCollection` which is populated with the elements stored in the database.
 
     - Parameter realm: The Realm Swift object to use.
    */
    public init(realm: MockableRealm) {
        self.realm = realm
        self.collection = realm.queryAll(T.self)
    }

    /**
     Returns an object at the given index.
     
     - Parameter index: The index of the object.
     - Returns: The object at the given index.
    */
    public subscript(index: Int) -> T {
        return collection[index]
    }

    /// The number of elements in the collection.
    public var count: Int {
        return collection.count
    }

    /**
     Adds an object to the collection and persists it in the database.
     
     - Parameter element: The element to add to the collection and to the database.
     */
    public func add(_ element: T) throws {
        try realm.write {
            realm.add(element)
        }
        
        collection.append(element)
    }

    /**
     Performs actions contained within the given block inside a write transaction.
     
     - Parameter block: The block containing actions to perform.
    */
    public func update(_ block: (() throws -> Void)) throws {
        try realm.write(block)
    }

    /**
     Deletes an element from the collection and the database. If the element is not found within the collection, this
     method does nothing.
     
     - Parameter element: The element to delete from the collection and the database.
    */
    public func delete(_ element: T) throws {
        if let index = collection.index(of: element) {
            try delete(at: index)
        }
    }

    /**
     Deletes an object at the specified index from the collection and the database.
     
     - Parameter index: The index of the element to delete from the collection and the database.
     */
    public func delete(at index: Int) throws {
        try realm.write {
            realm.delete(collection[index])
        }
        
        collection.remove(at: index)
    }
}
