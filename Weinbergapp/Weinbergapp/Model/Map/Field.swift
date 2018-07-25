//
//  Field.swift
//  Weinbergapp
//
//  Created by VM on 23.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Represents a field on the map.
 */
public struct Field {

    /// The name of the field.
    var name: String

    // The vine variety of the field.
    var vineVariety: String

    // The coordinates constructing the polygon of the field
    var coordinates: [CLLocationCoordinate2D]
}
