//
//  PlantProtectionCategory.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the category of illnesses to protect for in the plant protection operation.
 These are divided into three categories:

 * Fungicidal
 * Herbicide
 * Insecticidal/Acaricidal

 ````
 case fungicidal
 case herbicide
 case insecticidalOrAcaricidal
 ````
 */
public enum PlantProtectionCategory: Int {
    
    /// The fungicidal category
    case fungicidal
    
    /// The herbicide category
    case herbicide
    
    /// The insecticidal or acaricidal category
    case insecticidalOrAcaricidal
}
