//
//  Pesticides.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the pesticides used for the plant protection operation.
 */
public class PlantProtectionPesticides: Object {

    /// Represents the pesticide "Botector"
    @objc public dynamic var botector: Bool = false

    /// Represents the pesticide "Cantus"
    @objc public dynamic var cantus: Bool = false

    /// Represents the pesticide "Gibbb3"
    @objc public dynamic var gibbb3: Bool = false

    /// Represents the pesticide "Melody Combi"
    @objc public dynamic var melodyCombi: Bool = false

    /// Represents the pesticide "Prolectus"
    @objc public dynamic var prolectus: Bool = false

    /// Represents the pesticide "Pyrus; Babel"
    @objc public dynamic var pyrusBabel: Bool = false

    /// Represents the pesticide "Regalis Plus"
    @objc public dynamic var regalisPlus: Bool = false

    /// Represents the pesticide "Scala"
    @objc public dynamic var scala: Bool = false

    /// Represents the pesticide "Switch"
    @objc public dynamic var `switch`: Bool = false

    /// Represents the pesticide "Teldor"
    @objc public dynamic var teldor: Bool = false
    
    public func copy(to: PlantProtectionPesticides) {
        to.copy(from: self)
    }
    
    public func copy(from: PlantProtectionPesticides) {
        self.botector = from.botector
        self.cantus = from.cantus
        self.gibbb3 = from.gibbb3
        self.melodyCombi = from.melodyCombi
        self.prolectus = from.prolectus
        self.pyrusBabel = from.pyrusBabel
        self.regalisPlus = from.regalisPlus
        self.scala = from.scala
        self.`switch` = from.`switch`
        self.teldor = from.teldor
    }
}
