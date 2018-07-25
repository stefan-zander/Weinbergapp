//
//  PlantProtection.swift
//  Weinbergapp
//
//  Created by VM on 16.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the information required for the plant protection operation.
 */
public struct PlantProtection {

    /// The date on which the plant protection operation takes place.
    var date: Date

    /// The field associated with the plant protection operation.
    var field: String

    /// The user associated with the plant protection operation.
    var user: String

    /// The approximate working hours for the plant protection operation.
    var workingHours: Double

    /// The kind of plant protection used for this plant protection operation.
    var plantProtectionKind: PlantProtectionKind

    /// The pesticides used for this plant protection operation.
    var pesticides: PlantProtectionPesticides

    /// The treatment schedule for this plant protection operation.
    var treatmentSchedule: PlantProtectionTreatmentSchedule

    /// Optional additional information for the plant protection operation.
    var additionalInformation: String

    /// The applied amount of the plant protection operation.
    var appliedAmount: Double
}
