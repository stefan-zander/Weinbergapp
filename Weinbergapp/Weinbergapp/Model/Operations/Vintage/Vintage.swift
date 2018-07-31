//
//  Vintage.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the information required for the vintage operation.
 */
public class Vintage: Object {

    /// The date on which the vintage operation takes place.
    @objc public dynamic var date: Date = Date()

    /// The field associated with the vintage operation.
    @objc public dynamic var field: String = ""

    /// The user associated with the vintage operation.
    @objc public dynamic var user: String = ""

    /// The approximate working hours for the vintage operation.
    @objc public dynamic var workingHours: Double = 0.0

    /**
     The raw value of the way of execution for the vintage operation.

     - Remark:
         This property exists in order to remain compatible to Realm Swift, for the properly typed version see property
         `execution`.
     */
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
}
