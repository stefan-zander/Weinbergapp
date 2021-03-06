//
//  Fertilization.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 The Fertilization operation.
 */
public class Fertilization: Operation {

    /**
     The raw value of the fertilizer category used for the fertilization operation.

     - Remark:
     This property exists in order to remain compatible to Realm Swift, for the properly typed version see property
     `fertilizerCategory`.
     */
    @objc public dynamic var fertilizerCategoryRaw: Int = 0

    /**
     The raw value of the mineral fertilizer used for the fertilization operation.

     - Remark:
     This property exists in order to remain compatible to Realm Swift, for the properly typed version see property
     `mineralFertilizer`.
     */
    @objc public dynamic var mineralFertilizerRaw: Int = 0

    /**
     The raw value of the organic fertilizer used for the fertilization operation.

     - Remark:
     This property exists in order to remain compatible to Realm Swift, for the properly typed version see property
     `organicFertilizer`.
     */
    @objc public dynamic var organicFertilizerRaw: Int = 0

    /// The applied amount of the fertilization operation.
    @objc public dynamic var appliedAmount: Double = 0.0

    /// The fertilizer category used for the fertilization operation.
    public var fertilizerCategory: FertilizerCategory {
        get {
            return FertilizerCategory(rawValue: fertilizerCategoryRaw)!
        }
        set(category) {
            fertilizerCategoryRaw = category.rawValue
        }
    }

    /// The mineral fertilizer used for the fertilization operation.
    public var mineralFertilizer: MineralFertilizer {
        get {
            return MineralFertilizer(rawValue: mineralFertilizerRaw)!
        }
        set(fertilizer) {
            mineralFertilizerRaw = fertilizer.rawValue
        }
    }

    /// The organic fertilizer used for the fertilization operation.
    public var organicFertilizer: OrganicFertilizer {
        get {
            return OrganicFertilizer(rawValue: organicFertilizerRaw)!
        }
        set(fertilizer) {
            organicFertilizerRaw = fertilizer.rawValue
        }
    }
}
