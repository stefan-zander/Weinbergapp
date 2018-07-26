//
//  MKField.swift
//  Weinbergapp
//
//  Created by VM on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MKField {

    var field: Field
    var polygon: MKFieldPolygon
    var point: MKFieldPointAnnotation

    init(fromField: Field) {
        field = fromField
        polygon = MKFieldPolygon(coordinates: field.coordinates, count: field.coordinates.count)
        point = MKFieldPointAnnotation()

        polygon.owner = self
        point.owner = self

        updateText()
        updateCoordinates()
    }

    public func changeNameAndVineVariety(newName: String, newVineVariety: String) {
        self.field = Field(name: newName,
                           vineVariety: newVineVariety,
                           coordinates: self.field.coordinates)

        updateText()
    }

    public func changeCoordinates(newCoordinates: [CLLocationCoordinate2D]) {
        self.field = Field(name: self.field.name,
                           vineVariety: self.field.vineVariety,
                           coordinates: newCoordinates)
        
        polygon = MKFieldPolygon(coordinates: newCoordinates, count: newCoordinates.count)
        polygon.owner = self

        updateCoordinates()
    }

    public func add(to mapView: MKMapView) {
        mapView.add(polygon)
        mapView.addAnnotation(point)
    }

    public func remove(from mapView: MKMapView) {
        mapView.remove(polygon)
        mapView.removeAnnotation(point)
    }

    private func updateText() {
        point.title = "\(field.name) (\(String.init(format: "%.2f", field.areaInSquareKilometers)) km²)"
        point.subtitle = "Reben Sorte: \(field.vineVariety)"
    }

    private func updateCoordinates() {
        point.coordinate = polygon.coordinate
    }
}
