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
        if let fieldMarkerAnnotation = mapView.dequeueReusableAnnotationView(
            withIdentifier: "fieldPinAnnotation") {
            fieldMarkerAnnotation.annotation = self
            return fieldMarkerAnnotation
        }

        let fieldMarkerAnnotation = MKPinAnnotationView(annotation: self,
                                                           reuseIdentifier: "fieldPinAnnotation")
        fieldMarkerAnnotation.tintColor = .orange

        fieldMarkerAnnotation.canShowCallout = true
        fieldMarkerAnnotation.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return fieldMarkerAnnotation
    }
}
