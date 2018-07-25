//
//  FieldCollection.swift
//  Weinbergapp
//
//  Created by VM on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

class MapFieldCollection {

    private let mapView: MKMapView

    var fields: [MKFieldPolygon] = []

    init(for mapView: MKMapView) {
        self.mapView = mapView
    }

    func append(name: String, vineVariety: String, coordinates: [CLLocationCoordinate2D]) {
        let newField = Field(name: name,
                             vineVariety: vineVariety,
                             coordinates: coordinates)

        let newPolygon = MKFieldPolygon(coordinates: newField.coordinates, count: newField.coordinates.count)
        newPolygon.field = newField

        let newPoint = MKFieldPointAnnotation(owner: newPolygon)
        newPoint.coordinate = newPolygon.coordinate
        newPoint.title = newField.name
        newPoint.subtitle = newField.vineVariety
        newPolygon.point = newPoint

        fields.append(newPolygon)
        mapView.add(newPolygon)
        mapView.addAnnotation(newPoint)
    }
}
