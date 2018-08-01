//
//  Field.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 23.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

/**
 Represents a field on the map.
 */
public class Field: Object {

    /// The name of the field.
    @objc public dynamic var name: String = ""

    /// The vine variety of the field.
    @objc public dynamic var vineVariety: String = ""

    /// The raw value of the coordinates constructing the polygon of the field
    public let rawCoordinates = List<Double>()
    
    /// All fertilization operations that are done on this field
    public let fertilizations = LinkingObjects(fromType: Fertilization.self, property: "field")
    
    /// All defoliation operations that are done on this field
    public let defoliations = LinkingObjects(fromType: Defoliation.self, property: "field")
    
    /// All plant protection operations that are done on this field
    public let plantProtections = LinkingObjects(fromType: PlantProtection.self, property: "field")
    
    /// All vintage operations that are done on this field
    public let vintages = LinkingObjects(fromType: Vintage.self, property: "field")

    private var area: Double?
    
    public var useCount: Int {
        return fertilizations.count +
               defoliations.count +
               plantProtections.count +
               vintages.count
    }
    
    /**
     An array of property names that will not be persisted in the database
 
     - Returns: The array of property names.
    */
    public override static func ignoredProperties() -> [String] {
        return ["area"]
    }

    /**
     Computes the area of the field measured in meters.
     
     - Returns: The area of the field measured in meters.
     */
    public func getArea() -> Double {
        if let area = area {
            return area
        }
        
        let newArea = computeArea(coordinates: getCoordinates())
        area = newArea
        return newArea
    }
    
    /**
     Gets the coordinates that construct the polygon associated with this field.
 
     - Returns: The coordinates of the polygon.
    */
    public func getCoordinates() -> [CLLocationCoordinate2D] {
        let coordinatesCount = rawCoordinates.count / 2
        
        var coordinates: [CLLocationCoordinate2D] = []
        coordinates.reserveCapacity(coordinatesCount)
        
        for index in 0..<coordinatesCount {
            coordinates.append(CLLocationCoordinate2D(latitude: rawCoordinates[2 * index],
                                                      longitude: rawCoordinates[2 * index + 1]))
        }
        
        return coordinates
    }
    
    /**
     Sets the coordinates that construct the polygon associated with this field.
 
     - Parameter coordinates: The coordinates of the new polygon.
    */
    public func setCoordinates(_ coordinates: [CLLocationCoordinate2D]) {
        rawCoordinates.removeAll()
        
        for coordinate in coordinates {
            rawCoordinates.append(coordinate.latitude)
            rawCoordinates.append(coordinate.longitude)
        }
        
        // invalidate cached area
        area = nil
    }
}
