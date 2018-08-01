//
//  MockedRealm.swift
//  WeinbergappTests
//
//  Created by VM on 01.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift
@testable import Weinbergapp

class MockedRealm: MockableRealm {
    
    var objects: [Object] = []
    
    func queryAll<Element>(_ type: Element.Type) -> [Element] where Element : Object {
        var results: [Element] = []
        
        for object in objects {
            if let element = object as? Element {
                results.append(element)
            }
        }
        
        return results
    }
    
    func write(_ block: (() throws -> Void)) throws {
        try block()
    }
    
    func add(_ object: Object) {
        objects.append(object)
    }
    
    func delete(_ object: Object) {
        if let index = objects.index(of: object) {
            objects.remove(at: index)
        }
    }
}
