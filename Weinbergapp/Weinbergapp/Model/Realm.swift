//
//  Realm.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm: MockableRealm {

    /**
     Returns all objects of the given type stored in the Realm.

     - Returns: An array containing the objects
     */
    public func queryAll<Element>(_ type: Element.Type) -> [Element] where Element: Object {
        return Array(objects(type))
    }

    /**
     Adds or updates an existing object into the Realm.

     - Parameter object: The object to be added to this Realm.
    */
    public func add(_ object: Object) {
        add(object, update: false)
    }
}
