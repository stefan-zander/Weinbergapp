//
//  MapFieldCollection.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 01.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MapFieldCollection {
    
    private let realm: MockableRealm    
    private var fields: [MapField] = []
    private var currentMapView: MKMapView?
    
    init(realm: MockableRealm) {
        self.realm = realm
        self.fields = realm.queryAll(Field.self).map { MapField(field: $0, fieldCollection: self) }
    }
    
    public var mapView: MKMapView? {
        get {
            return currentMapView
        }
        set(mapView) {
            guard mapView != currentMapView else { return }
            
            if let previousMapView = currentMapView {
                for field in fields {
                    field.removeFromMapView(mapView: previousMapView)
                }
            }
            
            currentMapView = mapView
            
            if let nextMapView = currentMapView {
                for field in fields {
                    field.addToMapView(mapView: nextMapView)
                }
            }
        }
    }
    
    public func add(_ field: Field) throws {
        try realm.write {
            realm.add(field)
        }
        
        let mapField = MapField(field: field, fieldCollection: self)
        
        fields.append(mapField)
        
        if let currentMapView = currentMapView {
            mapField.addToMapView(mapView: currentMapView)
        }
    }
    
    public func update(_ block: (() throws -> Void)) throws {
        try realm.write(block)
    }
    
    public func delete(_ field: MapField) throws {
        guard let index = fields.index(where: { $0 === field }) else { return }
        
        try realm.write {
            realm.delete(field.field)
        }
        
        if let currentMapView = currentMapView {
            field.removeFromMapView(mapView: currentMapView)
        }
        
        fields.remove(at: index)
    }
}
