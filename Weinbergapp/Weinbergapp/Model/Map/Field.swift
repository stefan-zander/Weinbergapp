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
    public let name: String

    /// The vine variety of the field.
    public let vineVariety: String

    /// The coordinates constructing the polygon of the field
    public let coordinates: [CLLocationCoordinate2D]
    
    /// The total area of the field in square meters
    public let area: Double
    
    init(name: String, vineVariety: String, coordinates: [CLLocationCoordinate2D]) {
        self.name = name
        self.vineVariety = vineVariety
        self.coordinates = coordinates
        self.area = computeArea(coordinates: coordinates)
    }
    
    var areaInSquareMeters: Double {
        return area
    }
    
    var areaInSquareKilometers: Double {
        return area / (1000.0 * 1000.0)
    }
}
