//
//  MKPreviewPolygon.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MKPreviewPolygon: MKPolygon {

    public static let kPreviewPolygonFillColor = UIColor.blue.withAlphaComponent(0.25)
    public static let kPreviewPolygonStrokeColor = UIColor.blue.withAlphaComponent(0.5)
    public static let kPreviewPolygonLineWidth: CGFloat = 2.0
    public static let kPreviewPolygonLineDashPattern: [NSNumber] = [8, 8]

    public static func makeRenderer(rendererFor overlay: MKOverlay) -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)

        renderer.fillColor = kPreviewPolygonFillColor
        renderer.strokeColor = kPreviewPolygonStrokeColor
        renderer.lineWidth = kPreviewPolygonLineWidth
        renderer.lineDashPattern = kPreviewPolygonLineDashPattern

        return renderer
    }
}
