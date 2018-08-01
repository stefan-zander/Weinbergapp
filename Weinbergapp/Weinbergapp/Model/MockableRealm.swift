//
//  MockableRealm.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 A protocol for a mockable Realm Swift instance.
 */
public protocol MockableRealm {
    
    /**
     Returns all objects of the given type stored in the Realm.
     
     - Returns: An array containing the objects
     */
    func queryAll<Element: Object>(_ type: Element.Type) -> [Element]
    
    /**
     Performs actions contained within the given block inside a write transaction.
     
     - Parameter block: The block containing actions to perform.
     */
    func write(_ block: (() throws -> Void)) throws
    
    /**
     Adds or updates an existing object into the Realm.
     
     - Parameter object: The object to be added to this Realm.
     */
    func add(_ object: Object)
    
    /**
     Deletes an object from the Realm.
     
     - Parameter object: The object to be deleted.
    */
    func delete(_ object: Object)
}
