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

    private var cachedArea: Double?

    /// The area of the field measured in meters.
    public var area: Double {
        if let area = cachedArea {
            return area
        }

        let area = computeArea(coordinates: coordinates)
        cachedArea = area
        return area
    }

    ///The coordinates constructing the polygon of the field
    public var coordinates: [CLLocationCoordinate2D] {
        get {
            let coordinatesCount = rawCoordinates.count / 2

            var coordinates: [CLLocationCoordinate2D] = []
            coordinates.reserveCapacity(coordinatesCount)

            for index in 0..<coordinatesCount {
                coordinates.append(CLLocationCoordinate2D(latitude: rawCoordinates[2 * index],
                                                          longitude: rawCoordinates[2 * index + 1]))
            }

            return coordinates
        }
        set(coordinates) {
            rawCoordinates.removeAll()

            for coordinate in coordinates {
                rawCoordinates.append(coordinate.latitude)
                rawCoordinates.append(coordinate.longitude)
            }
        }
    }
}
