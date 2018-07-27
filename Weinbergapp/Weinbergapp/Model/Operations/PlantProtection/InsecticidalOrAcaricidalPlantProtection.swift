//
//  InsecticidalOrAcaricidalPlantProtection.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the insecticidal or acaricidal illnesses to protect for in the plant protection operation.
 */
public class InsecticidalOrAcaricidalPlantProtection: Object {

    /// Represents the insecticidal or acaricidal illnesses "Drosophila species".
    @objc public dynamic var drosophilaSpecies: Bool = false

    /// Represents the insecticidal or acaricidal illnesses "Grapevine rust mites".
    @objc public dynamic var grapevineRustMites: Bool = false

    /// Represents the insecticidal or acaricidal illnesses "Willow beauty".
    @objc public dynamic var willowBeauty: Bool = false

    /// Represents the insecticidal or acaricidal illnesses "Spider mites".
    @objc public dynamic var spiderMites: Bool = false

    /// Represents the insecticidal or acaricidal illnesses "Spring worm".
    @objc public dynamic var springWorm: Bool = false

    /// Represents the insecticidal or acaricidal illnesses "Grape".
    @objc public dynamic var grape: Bool = false

    /// Represents the insecticidal or acaricidal illnesses "Cicadas".
    @objc public dynamic var cicadas: Bool = false
    
    public func copy(to: InsecticidalOrAcaricidalPlantProtection) {
        to.copy(from: self)
    }
    
    public func copy(from: InsecticidalOrAcaricidalPlantProtection) {
        self.drosophilaSpecies = from.drosophilaSpecies
        self.grapevineRustMites = from.grapevineRustMites
        self.willowBeauty = from.willowBeauty
        self.spiderMites = from.spiderMites
        self.springWorm = from.springWorm
        self.grape = from.grape
        self.cicadas = from.cicadas
    }
}
