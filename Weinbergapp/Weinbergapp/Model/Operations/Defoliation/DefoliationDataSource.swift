//
//  DefoliationDataSource.swift
//  Weinbergapp
//
//  Created by VM on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

public class DefoliationDataSource {
    var realm: Realm?
    
    public func query(defoliations: inout [Defoliation]) throws {
        let realm = try self.realm ?? Realm()
        
        defoliations = Array(realm.objects(Defoliation.self))
    }
    
    public func add(defoliation: Defoliation) throws {
        let realm = try self.realm ?? Realm()
        let maxId: Int? = realm.objects(Defoliation.self).max(ofProperty: "id")
        
        defoliation.id = (maxId ?? 0) + 1
        
        try realm.write {
            realm.add(defoliation)
        }
    }
    
    public func update(_ block: (() throws -> Void)) throws {
        let realm = try self.realm ?? Realm()
        try realm.write(block)
    }
    
    public func delete(defoliation: Defoliation) throws {
        let realm = try self.realm ?? Realm()
        
        try realm.write {
            realm.delete(defoliation)
        }
    }
    
}
