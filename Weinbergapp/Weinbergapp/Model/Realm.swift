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
    
    func queryAll<Element>(_ type: Element.Type) -> [Element] where Element: Object {
        return Array(objects(type))
    }
    
    func add(_ object: Object) {
        add(object, update: false)
    }
}
