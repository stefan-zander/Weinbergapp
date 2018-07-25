//
//  Defoliation.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the information required for the fertilization operation.
 */
public struct Defoliation {
    
    /// The date on which the defoliation operation takes place
    var date: Date
    
    /// The field associated with the defoliation operation
    var field: String
    
    /// The user associated with the defoliation operation
    var user: String
    
    /// The approximate working hours for the defoliation operation
    var workingHours: Double
}
