//
//  MKPreviewPointAnnotation.swift
//  Weinbergapp
//
//  Created by VM on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MKPreviewPointAnnotation: MKPointAnnotation {

    func getAnnotationView(in mapView: MKMapView) -> MKAnnotationView {
        if let previewPointAnnotation = mapView.dequeueReusableAnnotationView(
            withIdentifier: "previewPointAnnotation") {
            previewPointAnnotation.annotation = self
            return previewPointAnnotation
        }

        let previewPointAnnotation = MKPinAnnotationView(annotation: self,
                                                         reuseIdentifier: "previewPointAnnotation")
        previewPointAnnotation.pinTintColor = .blue
        previewPointAnnotation.isDraggable = true
        previewPointAnnotation.canShowCallout = true
        previewPointAnnotation.animatesDrop = true

        let removeButton = UIButton(type: .detailDisclosure)
        removeButton.setImage(UIImage(named: "trash"), for: .normal)
        previewPointAnnotation.rightCalloutAccessoryView = removeButton

        return previewPointAnnotation
    }
}
