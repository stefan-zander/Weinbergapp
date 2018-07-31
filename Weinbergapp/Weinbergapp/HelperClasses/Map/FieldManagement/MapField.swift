//
//  MapField.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

class MapField {
    
    let field: Field
    let fieldDataSource: RealmDataSource<Field>
    let mapView: MKMapView
    
    private var isDisplayedOnMap = false
    private var polygon: MKFieldPolygon?
    private var point: MKFieldPointAnnotation?

    init(field: Field, fieldDataSource: RealmDataSource<Field>, mapView: MKMapView) {
        self.field = field
        self.fieldDataSource = fieldDataSource
        self.mapView = mapView
    }
    
    public var name: String {
        return field.name
    }
    
    public var vineVariety: String {
        return field.vineVariety
    }
    
    public var displayedOnMap: Bool {
        get {
            return isDisplayedOnMap
        }
        set(displayOnMap) {
            guard displayOnMap != isDisplayedOnMap else { return }
            
            if displayOnMap {
                addToMapView()
                isDisplayedOnMap = true
            } else {
                removeFromMapView()
                isDisplayedOnMap = false
            }
        }
    }
    
    public func changeText(name: String, vineVariety: String) throws {
        try fieldDataSource.update {
            field.name = name
            field.vineVariety = vineVariety
        }
        
        if let point = point {
            update(point: point)
        }
    }
    
    private func addToMapView() {
        if let polygon = self.polygon {
            mapView.remove(polygon)
        }
        
        let coordinates = field.coordinates
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
    
    private func update(point: MKFieldPointAnnotation) {
        point.title = "\(field.name) (\(MapLocalization.localize(area: field.area)))"
        point.subtitle = "Reben Sorte: \(field.vineVariety)"
    }

    private func removeFromMapView() {
        if let polygon = polygon {
            mapView.remove(polygon)
            self.polygon = nil
        }
        
        if let point = point {
            mapView.removeAnnotation(point)
            self.point = nil
        }
    }
}
