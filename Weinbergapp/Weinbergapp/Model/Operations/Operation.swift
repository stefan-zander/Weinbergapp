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
 An Operation class which contains the basic information required for any operation. This class is not intended to be
 used directly, but rather it's four subclasses: `Fertilization`, `Defoliation`, `PlantProtection` and `Vintage`.
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
