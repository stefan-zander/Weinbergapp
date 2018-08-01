//
//  MapFieldCollection.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 01.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 Provides a collection of fields that is persisted within the Realm Swift database
 */
public class FieldCollection {
    
    private let realm: MockableRealm    
    private var mapFields: [MapField] = []
    private var currentMapView: MKMapView?
    
    /**
     Creates a new `FieldCollection` which is populated with the fields stored in the database.
     
     - Parameter realm: The Realm Swift object to use.
    */
    public init(realm: MockableRealm) {
        self.realm = realm
        self.mapFields = realm.queryAll(Field.self).map { MapField(field: $0, fieldCollection: self) }
    }
    
    /// The `MKMapView` to use to display the fields on. If this property is `nil`, no fields are drawn.
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
    
    /**
     Attempts to find the index of a field within the collection.

     - Parameter field: The field to look for.
     - Returns: The index of the given field or `nil` there was no match.
     */
    public func index(of field: Field) -> Int? {
        return mapFields.index(where: { $0.field === field })
    }
    
    /**
     Returns a field at the given index.
 
     - Parameter index: The index of the field.
     - Returns: The field at the given index.
    */
    public subscript(index: Int) -> Field {
        return mapFields[index].field
    }
    
    /// The number of fields within the collection.
    public var count: Int {
        return mapFields.count
    }
    
    /**
     Adds a field to the collection and persists it in the database. If the `mapView` property is set, it will also add
     a visual representation to the `MKMapView`.
     
     - Parameter field: The field to add to the collection.
    */
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
    
    /**
     Performs actions contained within the given block inside a write transaction.
     
     - Parameter block: The block containing actions to perform.
     */
    public func update(_ block: (() throws -> Void)) throws {
        try realm.write(block)
    }
    
    /**
     Deletes a field from the collection and from the database. If the `mapView` property is set, the visual
     representation will also be removed from the `MKMapView`. If the field is not found within the collection, this
     method does nothing.
     
     - Parameter field: The field to delete from the collection.
    */
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
