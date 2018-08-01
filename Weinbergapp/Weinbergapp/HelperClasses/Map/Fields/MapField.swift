//
//  MapField.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MapField {

    public let field: Field
    public let fieldCollection: MapFieldCollection

    private var polygon: MKFieldPolygon?
    private var point: MKFieldPointAnnotation?

    init(field: Field, fieldCollection: MapFieldCollection) {
        self.field = field
        self.fieldCollection = fieldCollection
    }

    public var name: String {
        return field.name
    }

    public var vineVariety: String {
        return field.vineVariety
    }

    public func changeText(name: String, vineVariety: String) throws {
        try fieldCollection.update {
            field.name = name
            field.vineVariety = vineVariety
        }

        if let point = point {
            update(point: point)
        }
    }

    public func addToMapView(mapView: MKMapView) {
        if let polygon = self.polygon {
            mapView.remove(polygon)
        }

        let coordinates = field.getCoordinates()
        let polygon = MKFieldPolygon(owner: self, coordinates: coordinates, count: coordinates.count)

        self.polygon = polygon
        mapView.add(polygon)

        if let point = point {
            update(point: point)
            point.coordinate = polygon.coordinate
        } else {
            let point = MKFieldPointAnnotation(owner: self)
            update(point: point)
            point.coordinate = polygon.coordinate
            self.point = point
            mapView.addAnnotation(point)
        }
    }

    public func removeFromMapView(mapView: MKMapView) {
        if let polygon = polygon {
            mapView.remove(polygon)
            self.polygon = nil
        }

        if let point = point {
            mapView.removeAnnotation(point)
            self.point = nil
        }
    }
    
    private func update(point: MKFieldPointAnnotation) {
        point.title = "\(field.name) (\(MapLocalization.localize(area: field.getArea())))"
        point.subtitle = "Reben Sorte: \(field.vineVariety)"
    }
}
