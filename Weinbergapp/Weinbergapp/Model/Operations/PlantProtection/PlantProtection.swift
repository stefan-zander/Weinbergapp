//
//  PlantProtection.swift
//  Weinbergapp
//
//  Created by VM on 16.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

struct PlantProtection {
    var date: Date
    var field: String
    var user: String
    var workingHours: Double
    var category: PlantProtectionCategory
    var applicationAgainst: [Bool]
    var pesticides: [Bool]
    var treatmentSchedule: PlantProtectionTreatmentSchedule
    var additionalInformation: String
    var appliedAmount: Double
}

enum PlantProtectionCategory: Int {
    case Fungicidal = 0
    case Herbicide = 1
    case InsecticidalOrAcaricidal = 2
}


