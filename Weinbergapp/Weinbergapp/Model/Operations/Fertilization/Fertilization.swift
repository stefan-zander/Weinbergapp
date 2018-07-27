//
//  Fertilization.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the information required for the fertilization operation.
 */
public class Fertilization: Object {

    /// A unique identification number for each fertilization operation.
    @objc public dynamic var id: Int = 0
    
    /// The date on which the fertilization operation takes place.
    @objc public dynamic var date: Date = Date()

    /// The field associated with the fertilization operation.
    @objc public dynamic var field: String = ""

    /// The user associated with the fertilization operation.
    @objc public dynamic var user: String = ""

    /// The approximate working hours for the fertilization operation.
    @objc public dynamic var workingHours: Double = 0.0
    
    /// The fertilizer category used for the fertilization operation.
    @objc public dynamic var fertilizerCategoryRaw: Int = 0
    
    /// The mineral fertilizer used for the fertilization operation.
    @objc public dynamic var mineralFertilizerRaw: Int = 0
    
    /// The organic fertilizer used for the fertilization operation.
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
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
