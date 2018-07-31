//
//  MapLocalization.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 29.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

class MapLocalization {
    
    static let kMetersPerKilometer = 1000.0
    static let kSquareMetersPerSquareKilometers = kMetersPerKilometer * kMetersPerKilometer
    
    static func localize(area: Double) -> String {
        if area < kSquareMetersPerSquareKilometers {
            return String.init(format: "%.2f m²", area)
        }
        
        let areaInSquareKilometers = area / kSquareMetersPerSquareKilometers
        return String.init(format: "%.2f km²", areaInSquareKilometers)
    }    
}
