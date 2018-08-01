//
//  Operation.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 28.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import RealmSwift

/**
 Represents the information required for the fertilization operation.
 */
public class Operation: Object {
    
    /// The date on which the operation takes place.
    @objc public dynamic var date: Date = Date()
    
    /// The field associated with the operation.
    @objc public dynamic var field: Field?
    
    /// The user associated with the operation.
    @objc public dynamic var user: String = ""
    
    /// The approximate working hours for the operation.
    @objc public dynamic var workingHours: Double = 0.0
}
