//
//  MKFieldPointAnnotation.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 A special annotation to use for the vertices of the fields displayed in `MapViewController`.
 */
public class MKFieldPointAnnotation: MKPointAnnotation {

    var owner: MapField!

    convenience init(owner: MapField) {
        self.init()
        self.owner = owner
    }

    /**
     Gets the annotation view to use for this `MKFieldPointAnnotation`.

     - Parameter mapView: A mapView where reusable annotation views can be cached.
     - Returns: The `MKAnnotationView` to use for this `MKFieldPointAnnotation`.
     */
    public func getAnnotationView(in mapView: MKMapView) -> MKAnnotationView {
        if let fieldPinAnnotation = mapView.dequeueReusableAnnotationView(
            withIdentifier: "fieldPinAnnotation") {
            fieldPinAnnotation.annotation = self
            return fieldPinAnnotation
        }

        let fieldPinAnnotation = MKPinAnnotationView(annotation: self,
                                                     reuseIdentifier: "fieldPinAnnotation")
        fieldPinAnnotation.tintColor = .orange
        fieldPinAnnotation.pinTintColor = .orange
        fieldPinAnnotation.canShowCallout = true
        fieldPinAnnotation.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return fieldPinAnnotation
    }
}
