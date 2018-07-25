//
//  Fertilization.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the information required for the fertilization operation.
 */
public struct Fertilization {
    
    /// The date on which the fertilization operation takes place.
    var date: Date
    
    /// The field associated with the fertilization operation.
    var field: String
    
    /// The user associated with the fertilization operation.
    var user: String
    
    /// The approximate working hours for the fertilization operation.
    var workingHours: Double
    
    /// The fertilizer used for the fertilization operation.
    var fertilizer: Fertilizer
    
    /// The applied amount of the fertilization process.
    var appliedAmount: Double
}
