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

    var fields: [MKField] = []

    init(for mapView: MKMapView) {
        self.mapView = mapView
    }

    func append(name: String, vineVariety: String, coordinates: [CLLocationCoordinate2D]) {
        append(field: Field(name: name,
                            vineVariety: vineVariety,
                            coordinates: coordinates))
    }

    func append(field: Field) {
        let newField = MKField(fromField: field)
        newField.add(to: mapView)
        fields.append(newField)
    }

}
