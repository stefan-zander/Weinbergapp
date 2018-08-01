//
//  MKDrawingPolygon.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 25.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 A special polygon to use for the polygon drawn with `MapPolygonDrawer`.
 */
public class MKDrawingPolygon: MKPolygon {
    
    /// The fill color to use for drawn polygon.
    public static let kDrawingPolygonFillColor = UIColor.blue.withAlphaComponent(0.25)
    
    /// The stroke color to use for the drawn polygon.
    public static let kDrawingPolygonStrokeColor = UIColor.blue.withAlphaComponent(0.5)
    
    /// The line width to use for the drawn polygon.
    public static let kDrawingPolygonLineWidth: CGFloat = 2.0
    
    /// The line dash pattern to use for the drawn polygon.
    public static let kDrawingPolygonLineDashPattern: [NSNumber] = [8, 8]
    
    /**
     Creates a renderer to use for this polygon given an overlay.
     
     - Parameter overlay: The overlay to use for the renderer.
     - Retruns: The renderer to use for this polygon.
     */
    public static func makeRenderer(rendererFor overlay: MKOverlay) -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        
        renderer.fillColor = kDrawingPolygonFillColor
        renderer.strokeColor = kDrawingPolygonStrokeColor
        renderer.lineWidth = kDrawingPolygonLineWidth
        renderer.lineDashPattern = kDrawingPolygonLineDashPattern
        
        return renderer
    }
}
