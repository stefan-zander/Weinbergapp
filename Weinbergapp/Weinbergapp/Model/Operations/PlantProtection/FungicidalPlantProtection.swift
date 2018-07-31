//
//  FungicidalPlantProtection.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the fungicidal illnesses to protect for in the plant protection operation.
 */
public class FungicidalPlantProtection: Object {

    /// Represents the fungicidal illnesses "Botrytis".
    @objc public dynamic var botrytis: Bool = false

    /// Represents the fungicidal illnesses "AcidRot".
    @objc public dynamic var acidRot: Bool = false

    /// Represents the fungicidal illnesses "Oidium".
    @objc public dynamic var oidium: Bool = false

    /// Represents the fungicidal illnesses "Peronospora".
    @objc public dynamic var peronospora: Bool = false

    /// Represents the fungicidal illnesses "Phomopsis".
    @objc public dynamic var phomopsis: Bool = false

    /// Represents the fungicidal illnesses "Red burner".
    @objc public dynamic var redBurner: Bool = false

    /**
     Copies the contents from another `FungicidalPlantProtection` object to this object.

     - Parameter from: The `FungicidalPlantProtection` object to copy from.
    */
    public func copy(from: FungicidalPlantProtection) {
        self.botrytis = from.botrytis
        self.acidRot = from.acidRot
        self.oidium = from.oidium
        self.peronospora = from.peronospora
        self.phomopsis = from.phomopsis
        self.redBurner = from.redBurner
    }

    /**
     Copies the contents of this object to another `FungicidalPlantProtection` object.

     - Parameter to: The `FungicidalPlantProtection` object to copy to.
     */
    public func copy(to: FungicidalPlantProtection) {
        to.copy(from: self)
    }
}
