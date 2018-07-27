//
//  Defoliation.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the information required for the defoliation operation.
 */
public class Defoliation: Object {
    
    /// A unique identification number for each defoliation operation.
    @objc dynamic var id: Int = 0
    
    /// The date on which the defoliation operation takes place.
    @objc dynamic var date: Date = Date()

    /// The field associated with the defoliation operation.
    @objc dynamic var field: String = ""

    /// The user associated with the defoliation operation.
    @objc dynamic var user: String = ""

    /// The approximate working hours for the defoliation operation.
    @objc dynamic var workingHours: Double = 0.0
    
    /// Represents the primary key used for identification purposes by Realm Swift
    public override static func primaryKey() -> String? {
        return "id"
    }
}
