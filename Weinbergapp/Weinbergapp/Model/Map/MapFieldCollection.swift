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
    private var mapFields: [MapField] = []
    private var currentMapView: MKMapView?
    
    init(realm: MockableRealm) {
        self.realm = realm
        self.mapFields = realm.queryAll(Field.self).map { MapField(field: $0, fieldCollection: self) }
    }
    
    public var mapView: MKMapView? {
        get {
            return currentMapView
        }
        set(mapView) {
            guard mapView != currentMapView else { return }
            
            if let previousMapView = currentMapView {
                for field in mapFields {
                    field.removeFromMapView(mapView: previousMapView)
                }
            }
            
            currentMapView = mapView
            
            if let nextMapView = currentMapView {
                for field in mapFields {
                    field.addToMapView(mapView: nextMapView)
                }
            }
        }
    }
    
    public func index(of field: Field) -> Int? {
        return mapFields.index(where: { $0.field === field })
    }
    
    public subscript(index: Int) -> Field {
        return mapFields[index].field
    }
    
    public var count: Int {
        return mapFields.count
    }
    
    public func add(_ field: Field) throws {
        try realm.write {
            realm.add(field)
        }
        
        let mapField = MapField(field: field, fieldCollection: self)
        
        mapFields.append(mapField)
        
        if let currentMapView = currentMapView {
            mapField.addToMapView(mapView: currentMapView)
        }
    }
    
    public func update(_ block: (() throws -> Void)) throws {
        try realm.write(block)
    }
    
    public func delete(_ field: Field) throws {
        guard let index = mapFields.index(where: { $0.field === field }) else { return }
        
        let mapField = mapFields[index]
        
        try realm.write {
            for fertilization in field.fertilizations {
                realm.delete(fertilization)
            }
            
            for defoliation in field.defoliations {
                realm.delete(defoliation)
            }
            
            for plantProtection in field.plantProtections {
                realm.delete(plantProtection)
            }
            
            for vintage in field.vintages {
                realm.delete(vintage)
            }
            
            realm.delete(mapField.field)
        }
        
        if let currentMapView = currentMapView {
            mapField.removeFromMapView(mapView: currentMapView)
        }
        
        mapFields.remove(at: index)
    }
}
