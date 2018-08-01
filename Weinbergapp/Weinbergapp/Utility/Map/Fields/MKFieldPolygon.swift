//
//  MKFieldPolygon.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 A special polygon to use for the fields displayed in `MapViewController`.
 */
public class MKFieldPolygon: MKPolygon {
    
    /// The fill color to use for the polygon belonging to a field.
    static let kFieldPolygonFillColor = UIColor.orange.withAlphaComponent(0.25)
    
    /// The stroke color to use for the polygon belonging to a field
    static let kFieldPolygonStrokeColor = UIColor.orange.withAlphaComponent(0.5)
    
    /// The line width to use for the polygon belonging to a field
    static let kFieldPolygonLineWidth: CGFloat = 2.0

    var owner: MapField!

    convenience init(owner: MapField, coordinates: UnsafePointer<CLLocationCoordinate2D>, count: Int) {
        self.init(coordinates: coordinates, count: count)
        self.owner = owner
    }

    /**
     Creates a renderer to use for this polygon given an overlay.
     
     - Parameter overlay: The overlay to use for the renderer.
     - Retruns: The renderer to use for this polygon.
     */
    public static func makeRenderer(rendererFor overlay: MKOverlay) -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)

        renderer.fillColor = kFieldPolygonFillColor
        renderer.strokeColor = kFieldPolygonStrokeColor
        renderer.lineWidth = kFieldPolygonLineWidth

        return renderer
    }
}
