//
//  PlantProtectionKind.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

public enum PlantProtectionKind {
    case fungicidal(FungicidalPlantProtection)
    case herbicide(HerbicidePlantProtection)
    case insecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection)
}
