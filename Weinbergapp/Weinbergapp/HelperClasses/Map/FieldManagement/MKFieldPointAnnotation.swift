//
//  MKFieldPointAnnotation.swift
//  Weinbergapp
//
//  Created by VM on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MKFieldPointAnnotation: MKPointAnnotation {

    var owner: MapField!
    
    convenience init(owner: MapField) {
        self.init()
        self.owner = owner
    }

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
