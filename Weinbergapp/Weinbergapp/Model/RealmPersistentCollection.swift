//
//  PersistentCollection.swift
//  Weinbergapp
//
//  Created by VM on 30.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmPersistentCollection<T: Object> {
    
    private let dataSource = RealmDataSource<T>()
    
    private var collection: [T] = []
    
    public subscript(index: Int) -> T {
        return collection[index]
    }
    
    public var count: Int {
        return collection.count
    }
    
    public func reload() throws {
        collection = try dataSource.queryAll()
    }
    
    public func add(_ element: T) throws {
        try dataSource.add(element)
        collection.append(element)
    }
    
    public func update(_ changes: (() throws -> Void)) throws {
        try dataSource.update(changes)
    }
    
    public func delete(_ element: T) throws {
        if let index = collection.index(of: element) {
            try delete(at: index)
        }
    }
    
    public func delete(at index: Int) throws {
        try dataSource.delete(collection[index])
        collection.remove(at: index)
    }
}