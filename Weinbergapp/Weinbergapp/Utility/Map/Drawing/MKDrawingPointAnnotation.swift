//
//  MKDrawingPointAnnotation.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 A special annotation to use for the vertices of polygons drawn with `MapPolygonDrawer`.
 */
public class MKDrawingPointAnnotation: MKPointAnnotation {

    /**
     Gets the annotation view to use for this `MKDrawingPointAnnotation`.

     - Parameter mapView: A mapView where reusable annotation views can be cached.
     - Returns: The `MKAnnotationView` to use for this `MKDrawingPointAnnotation`.
    */
    public func getAnnotationView(in mapView: MKMapView) -> MKAnnotationView {
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
