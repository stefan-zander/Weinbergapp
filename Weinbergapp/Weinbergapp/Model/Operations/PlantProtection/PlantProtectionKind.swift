//
//  PlantProtectionKind.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

enum PlantProtectionKind {
    case Fungicidal(FungicidalPlantProtection)
    case Herbicide(HerbicidePlantProtection)
    case InsecticidalOrAcaricidal(InsecticidalOrAcaricidalPlantProtection)
}
