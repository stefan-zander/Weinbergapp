//
//  MKPreviewPolygon.swift
//  Weinbergapp
//
//  Created by VM on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

class MKPreviewPolygon: MKPolygon {

    static let kPreviewPolygonFillColor = UIColor.blue.withAlphaComponent(0.25)
    static let kPreviewPolygonStrokeColor = UIColor.blue.withAlphaComponent(0.5)
    static let kPreviewPolygonLineWidth: CGFloat = 2.0
    static let kPreviewPolygonLineDashPattern: [NSNumber] = [8, 8]

    public static func makeRenderer(rendererFor overlay: MKOverlay) -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)

        renderer.fillColor = kPreviewPolygonFillColor
        renderer.strokeColor = kPreviewPolygonStrokeColor
        renderer.lineWidth = kPreviewPolygonLineWidth
        renderer.lineDashPattern = kPreviewPolygonLineDashPattern

        return renderer
    }
}
