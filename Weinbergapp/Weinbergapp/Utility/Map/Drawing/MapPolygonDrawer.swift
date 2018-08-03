//
//  MapPolygonDrawer.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

/**
 A class designed for drawing polygons on a `MKMapView`.
 */
public class MapPolygonDrawer {

    private let mapView: MKMapView

    private var addPointGesture: UILongPressGestureRecognizer!
    private var drawingPoints: [MKPointAnnotation]?
    private var drawingPolygon: MKPolygon?

    /**
     Initializes a new `MapPolygonDrawer` for the `MKMapView` `mapView`.

     - Parameter mapView: The `MKMapView` where a preview of the drawing polygon will be added.
     */
    public init(for mapView: MKMapView) {
        self.mapView = mapView

        addPointGesture = UILongPressGestureRecognizer(target: self,
                                                       action: #selector(addPointGestureReceived))
        addPointGesture.minimumPressDuration = 0.25
        mapView.addGestureRecognizer(addPointGesture)
    }

    deinit {
        mapView.removeGestureRecognizer(addPointGesture)
    }

    /// A `Bool` indicating whether drawing is currently enabled or disabled.
    public var isDrawing: Bool {
        return drawingPoints != nil
    }

    /// The number of points that are currently drawn.
    public var pointsDrawn: Int {
        if let drawingPoints = drawingPoints {
            return drawingPoints.count
        }

        return 0
    }

    /**
     Enter drawing mode with optional initial coordinates given.

     - Parameter coordinates: An array of coordinates that should already be drawn onto the map or `nil` to start from
                              scratch.
    */
    public func beginDraw(coordinates: [CLLocationCoordinate2D]?) {
        if let coordinates = coordinates {
            self.drawingPoints = coordinates.enumerated().map { (offset, element) -> MKPointAnnotation in
                return createPointAnnotation(index: offset, coordinate: element)
            }

            refreshDrawingPolygon()
        } else {
            self.drawingPoints = []
        }

        self.drawingPolygon = nil
    }

    /**
     Ends drawing mode and removes any created previews drawn on `mapView`.

     - Remarks: This method also resets the drawing points, so in order to use the class properly the coordinates need
                to be queried first before ending drawing mode.
    */
    public func endDraw() {
        if let drawingPoints = drawingPoints {
            self.mapView.removeAnnotations(drawingPoints)
            self.drawingPoints = nil
        }

        if let drawingPolygon = drawingPolygon {
            self.mapView.remove(drawingPolygon)
            self.drawingPolygon = nil
        }
    }

    /**
     When in drawing mode this method returns an array of coordinates that have been drawn, otherwise an empty array is
     returned.

     - Returns: The coordinates drawn so far.
    */
    public func getCoordinates() -> [CLLocationCoordinate2D] {
        if let drawingPoints = drawingPoints {
            return drawingPoints.map { $0.coordinate }
        }

        return []
    }

    /**
     Removes a point of the drawing polygon.

     - Parameter point: The point to remove from the drawing polygon.
    */
    public func remove(point: MKDrawingPointAnnotation) {
        guard var drawingPoints = drawingPoints else { return }
        guard let index = drawingPoints.index(of: point) else { return }

        mapView.removeAnnotation(point)
        drawingPoints.remove(at: index)

        for index in index..<drawingPoints.count {
            drawingPoints[index].title = "Punkt \(index + 1)"
        }

        self.drawingPoints = drawingPoints
        refreshDrawingPolygon()
    }

    @objc func addPointGestureReceived(gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        guard var drawingPoints = drawingPoints else { return }

        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let point = createPointAnnotation(index: drawingPoints.count, coordinate: coordinate)

        drawingPoints.append(point)

        self.mapView.addAnnotation(point)
        self.drawingPoints = drawingPoints

        refreshDrawingPolygon()
    }

    private func createPointAnnotation(index: Int, coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let point = MKDrawingPointAnnotation()

        point.title = "Punkt \(index + 1)"
        point.coordinate = coordinate

        return point
    }

    /**
     Redraws the preview of the currently drawn polygon.
    */
    public func refreshDrawingPolygon() {
        if let previousPolygon = drawingPolygon {
            mapView.remove(previousPolygon)
        }

        guard let drawingPoints = drawingPoints else { return }
        guard drawingPoints.count >= 3 else { return }

        let newPolygon = MKDrawingPolygon(coordinates: drawingPoints.map { $0.coordinate },
                                          count: drawingPoints.count)

        self.mapView.add(newPolygon)
        self.drawingPolygon = newPolygon
    }
}
