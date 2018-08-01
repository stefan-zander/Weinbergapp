//
//  MapField.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 A wrapper around a `Field` object that also provides capability to draw the field on an `MKMapVIew` and specify
 information next to it.
 */
public class MapField {

    /// The underlying field.
    public let field: Field
    
    /// The field collection this object belongs to.
    public let fieldCollection: FieldCollection

    private var mapView: MKMapView?
    private var polygon: MKFieldPolygon?
    private var point: MKFieldPointAnnotation?

    init(field: Field, fieldCollection: FieldCollection) {
        self.field = field
        self.fieldCollection = fieldCollection
    }

    /// The name of the underlying field.
    public var name: String {
        return field.name
    }

    /// The vine variety of the underlying field.
    public var vineVariety: String {
        return field.vineVariety
    }
    
    /// The number of operations that currently use the underlying field.
    public var useCount: Int {
        return field.useCount
    }

    /**
     Changes the name and vine variety of the underlying field and updates the visual representations on the `mapView`.
     
     - Parameter name: The new name to use for the field.
     - Parameter vineVariety: the new vine variety to use for the field.
     */
    public func changeText(name: String, vineVariety: String) throws {
        try fieldCollection.update {
            field.name = name
            field.vineVariety = vineVariety
        }

        if let point = point {
            update(point: point)
        }
    }

    /**
     Adds a visual representation to the given `mapView`, using the coordinates of the underlying field.
     
     - Parameter mapView: The `mapView` to add the visual representation to.
     - Remarks: If this method is called when it is already attached to a different `mapView`, the previous visual
                representations will be deleted first.
     */
    public func addToMapView(mapView: MKMapView) {
        if let mapView = self.mapView, let polygon = self.polygon {
            mapView.remove(polygon)
        }

        let coordinates = field.getCoordinates()
        let polygon = MKFieldPolygon(owner: self, coordinates: coordinates, count: coordinates.count)

        self.mapView = mapView
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

    /**
     Removes any visual representations created by `addToMapView`. If no visual representations have been created, this
     method does nothing.
     */
    public func removeFromMapView() {
        guard let mapView = mapView else { return }
        
        if let polygon = polygon {
            mapView.remove(polygon)
            self.polygon = nil
        }
        
        if let point = point {
            mapView.removeAnnotation(point)
            self.point = nil
        }
        
        self.mapView = nil
    }
    
    private func update(point: MKFieldPointAnnotation) {
        point.title = "\(field.name) (\(MapLocalization.localize(area: field.getArea())))"
        point.subtitle = "Reben Sorte: \(field.vineVariety)"
    }
}
