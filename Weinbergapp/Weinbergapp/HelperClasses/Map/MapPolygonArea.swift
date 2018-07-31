//
//  MapPolygonArea.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 26.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

import MapKit

/// The radius of the earth, given in meters.
let kEarthRadiusInMeters = 6378137.0

/// The radius of the earth, given in square meters.
let kEarthRadiusInMetersSquared = kEarthRadiusInMeters * kEarthRadiusInMeters

/**
 Converts an angle measured in degrees to radians.

 - Parameter degrees: An angle in degrees.
 - Returns: The converted angle in radians.
 */
public func radians(degrees: Double) -> Double {
    return degrees * Double.pi / 180.0
}

/**
 Returns the area of a given polygon.

 - Parameter coordinates: The polygon to compute the area for.
 - Returns: The area of the polygon in square meters.

 - Remark:
     This algorithm has been implemented according to formular "area of a polygon on a sphere", located on page 7 of
     [Some Algorithms for Polygons on a Sphere](
     https://trs-new.jpl.nasa.gov/bitstream/handle/2014/40409/JPL%20Pub%2007-3%20%20w%20Errata.pdf). The algorithm
     assumes the earth to be a sphere, which while giving a reasonably quick approximation, may not be perfectly
     accurate.
 */
public func computeArea(coordinates: [CLLocationCoordinate2D]) -> Double {
    guard coordinates.count > 2 else { return 0.0 }

    var area = 0.0

    for index in 0..<coordinates.count {
        let previousLocation = coordinates[index > 0 ? index - 1 : coordinates.count - 1]
        let currentLocation = coordinates[index]
        let nextLocation = coordinates[index < coordinates.count - 1 ? index + 1 : 0]

        let lambdas = radians(degrees: nextLocation.longitude - previousLocation.longitude)
        let sinus = sin(radians(degrees: currentLocation.latitude))

        area += lambdas * sinus
    }

    return abs(area * kEarthRadiusInMetersSquared / 2)
}
