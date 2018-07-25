//
//  PlantProtectionKind.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents what the plant protections (pesticides) should be used for in the plant protection operation.
 These are divided into three categories:

 * Fungicidal
 * Herbicide
 * Insecticidal/Acaricidal.

 ````
 case fungicidal(FungicidalPlantProtection)
 case herbicide(HerbicidePlantProtection)
 case insecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection)
 ````
 */
public enum PlantProtectionKind {
    case fungicidal(FungicidalPlantProtection)
    case herbicide(HerbicidePlantProtection)
    case insecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection)
}
