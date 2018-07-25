//
//  FungicidalPlantProtection.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the fungicidal illnesses to protect for in the plant protection operation.
 */
public struct FungicidalPlantProtection {

    /// Represents the fungicidal illnesses "Botrytis".
    var botrytis: Bool = false

    /// Represents the fungicidal illnesses "AcidRot".
    var acidRot: Bool = false

    /// Represents the fungicidal illnesses "Oidium".
    var oidium: Bool = false

    /// Represents the fungicidal illnesses "Peronospora".
    var peronospora: Bool = false

    /// Represents the fungicidal illnesses "Phomopsis".
    var phomopsis: Bool = false

    /// Represents the fungicidal illnesses "Red burner".
    var redBurner: Bool = false
}
