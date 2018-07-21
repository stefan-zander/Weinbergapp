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
    var plantProtectionKind: PlantProtectionKind
    var pesticides: PlantProtectionPesticides
    var treatmentSchedule: PlantProtectionTreatmentSchedule
    var additionalInformation: String
    var appliedAmount: Double
}
