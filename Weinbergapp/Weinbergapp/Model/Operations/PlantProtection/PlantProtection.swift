//
//  PlantProtection.swift
//  Weinbergapp
//
//  Created by VM on 16.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the information required for the plant protection operation.
 */
public class PlantProtection: Object {

    /// The date on which the plant protection operation takes place.
    @objc public dynamic var date: Date = Date()

    /// The field associated with the plant protection operation.
    @objc public dynamic var field: String = ""

    /// The user associated with the plant protection operation.
    @objc public dynamic var user: String = ""

    /// The approximate working hours for the plant protection operation.
    @objc public dynamic var workingHours: Double = 0.0

    /**
     The raw value of the category of illnesses to protect for in the plant protection operation.
     
     - Remark:
     This property exists in order to remain compatible to Realm Swift, for the properly typed version see property
     `plantProtectionCategory`.
     */
    @objc public dynamic var plantProtectionCategoryRaw: Int = 0
    
    /// The fungicidal illnesses to protect for in the plant protection operation.
    @objc public dynamic var fungicidalPlantProtection: FungicidalPlantProtection?
    
    /// The herbicide illnesses to protect for in the plant protection operation.
    @objc public dynamic var herbicidePlantProtection: HerbicidePlantProtection?
    
    /// The insecticidal or acaricidal illnesses to protect for in the plant protection operation.
    @objc public dynamic var insecticidalOrAcaricidalPlantProtection: InsecticidalOrAcaricidalPlantProtection?
    
    /// The pesticides used for this plant protection operation.
    @objc public dynamic var pesticides: PlantProtectionPesticides?

    /**
     The raw value of the treatment schedule for this plant protection operation.
     
     - Remark:
     This property exists in order to remain compatible to Realm Swift, for the properly typed version see property
     `treatmentSchedule`.
     */
    @objc public dynamic var treatmentScheduleRaw: Int = 0

    /// Optional additional information for the plant protection operation.
    @objc public dynamic var additionalInformation: String = ""

    /// The applied amount of the plant protection operation.
    @objc public dynamic var appliedAmount: Double = 0.0
    
    /// The category of illnesses to protect for in the plant protection operation.
    public var plantProtectionCategory: PlantProtectionCategory {
        get {
            return PlantProtectionCategory(rawValue: plantProtectionCategoryRaw)!
        }
        set(category) {
            plantProtectionCategoryRaw = category.rawValue
        }
    }
    
    /// The treatment schedule for this plant protection operation.
    public var treatmentSchedule: PlantProtectionTreatmentSchedule {
        get {
            return PlantProtectionTreatmentSchedule(rawValue: treatmentScheduleRaw)!
        }
        set(schedule) {
            treatmentScheduleRaw = schedule.rawValue
        }
    }
}
