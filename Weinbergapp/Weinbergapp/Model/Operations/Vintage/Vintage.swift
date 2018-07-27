//
//  Vintage.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the information required for the vintage operation.
 */
public class Vintage: Object {
    
    /// A unique identification number for each fertilization operation.
    @objc public dynamic var id: Int = 0

    /// The date on which the vintage operation takes place.
    @objc public dynamic var date: Date = Date()

    /// The field associated with the vintage operation.
    @objc public dynamic var field: String = ""

    /// The user associated with the vintage operation.
    @objc public dynamic var user: String = ""

    /// The approximate working hours for the vintage operation.
    @objc public dynamic var workingHours: Double = 0.0

    /// The way of execution for the vintage operation.
    @objc public dynamic var executionRaw: Int = 0
    
    /// The way of execution for the vintage operation.
    public var execution: VintageExecution {
        get {
            return VintageExecution(rawValue: executionRaw)!
        }
        set(execution) {
            executionRaw = execution.rawValue
        }
    }
    
    /// Represents the primary key used for identification purposes by Realm Swift
    public override static func primaryKey() -> String? {
        return "id"
    }
}
