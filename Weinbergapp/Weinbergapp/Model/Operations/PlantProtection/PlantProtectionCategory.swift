//
//  PlantProtectionKind.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
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
    case fungicidal
    case herbicide
    case insecticidalOrAcaricidal
}
