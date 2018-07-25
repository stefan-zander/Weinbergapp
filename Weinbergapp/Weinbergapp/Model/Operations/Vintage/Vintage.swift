//
//  Vintage.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the information required for the vintage operation.
 */
public struct Vintage {

    /// The date on which the vintage operation takes place.
    var date: Date

    /// The field associated with the vintage operation.
    var field: String

    /// The user associated with the vintage operation.
    var user: String

    /// The approximate working hours for the vintage operation.
    var workingHours: Double

    /// The way of execution for the vintage operation.
    var execution: VintageExecution
}
