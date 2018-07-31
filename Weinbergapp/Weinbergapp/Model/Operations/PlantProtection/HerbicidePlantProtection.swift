//
//  HerbicidePlantProtection.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents the herbicide illnesses to protect for in the plant protection operation.
 */
public class HerbicidePlantProtection: Object {

    /// Represents the herbicide illnesses "Bindweed".
    @objc public dynamic var bindweed: Bool = false

    /// Represents the herbicide illnesses "Monocotyledonous and dicotyledonous".
    @objc public dynamic var monocotyledonousAndDicotyledonous: Bool = false

    /**
     Copies the contents from another `HerbicidePlantProtection` object to this object.

     - Parameter from: The `HerbicidePlantProtection` object to copy from.
     */
    public func copy(from: HerbicidePlantProtection) {
        self.bindweed = from.bindweed
        self.monocotyledonousAndDicotyledonous = from.monocotyledonousAndDicotyledonous
    }

    /**
     Copies the contents of this object to another `HerbicidePlantProtection` object.

     - Parameter to: The `HerbicidePlantProtection` object to copy to.
     */
    public func copy(to: HerbicidePlantProtection) {
        to.copy(from: self)
    }
}
