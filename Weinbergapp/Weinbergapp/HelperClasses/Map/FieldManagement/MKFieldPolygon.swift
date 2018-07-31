//
//  MKFieldPolygon.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MKFieldPolygon: MKPolygon {

    static let kPreviewPolygonFillColor = UIColor.orange.withAlphaComponent(0.25)
    static let kPreviewPolygonStrokeColor = UIColor.orange.withAlphaComponent(0.5)
    static let kPreviewPolygonLineWidth: CGFloat = 2.0

    var owner: MapField!
    
    convenience init(owner: MapField, coordinates: UnsafePointer<CLLocationCoordinate2D>, count: Int) {
        self.init(coordinates: coordinates, count: count)
        self.owner = owner
    }

    public static func makeRenderer(rendererFor overlay: MKOverlay) -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)

        renderer.fillColor = kPreviewPolygonFillColor
        renderer.strokeColor = kPreviewPolygonStrokeColor
        renderer.lineWidth = kPreviewPolygonLineWidth

        return renderer
    }
}
