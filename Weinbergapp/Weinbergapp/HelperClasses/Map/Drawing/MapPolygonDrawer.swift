//
//  MapPolygonDrawer.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import MapKit

public class MapPolygonDrawer {

    private let mapView: MKMapView

    private var previewPoints: [MKPointAnnotation]?
    private var previewPolygon: MKPolygon?

    init(for mapView: MKMapView) {
        self.mapView = mapView

        let addPointGesture = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(addPointGestureReceived))
        addPointGesture.minimumPressDuration = 0.25
        mapView.addGestureRecognizer(addPointGesture)
    }

    public var isEnabled: Bool {
        return previewPoints != nil
    }

    public var pointsDrawn: Int {
        if let previewPoints = previewPoints {
            return previewPoints.count
        }

        return 0
    }

    public func enterPreviewMode(coordinates: [CLLocationCoordinate2D]?) {
        if let coordinates = coordinates {
            self.previewPoints = coordinates.enumerated().map { (offset, element) -> MKPointAnnotation in
                return createPointAnnotation(index: offset, coordinate: element)
            }

            refreshPreviewPolygon()
        } else {
            self.previewPoints = []
        }

        self.previewPolygon = nil
    }

    public func leavePreviewMode() {
        if let previewPoints = previewPoints {
            self.mapView.removeAnnotations(previewPoints)
            self.previewPoints = nil
        }

        if let previewPolygon = previewPolygon {
            self.mapView.remove(previewPolygon)
            self.previewPolygon = nil
        }
    }

    public func add(coordinate: CLLocationCoordinate2D) {
        guard var previewPoints = previewPoints else { return }

        previewPoints.append(createPointAnnotation(index: previewPoints.count, coordinate: coordinate))

        self.previewPoints = previewPoints

        refreshPreviewPolygon()
    }

    public func getCoordinates() -> [CLLocationCoordinate2D] {
        if let previewPoints = previewPoints {
            return previewPoints.map { $0.coordinate }
        }

        return []
    }

    public func remove(point: MKPointAnnotation) {
        guard var previewPoints = previewPoints else { return }
        guard let index = previewPoints.index(of: point) else { return }

        mapView.removeAnnotation(point)
        previewPoints.remove(at: index)

        for index in index..<previewPoints.count {
            previewPoints[index].title = "Punkt \(index + 1)"
        }

        self.previewPoints = previewPoints
        refreshPreviewPolygon()
    }

    @objc func addPointGestureReceived(gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        guard var previewPoints = previewPoints else { return }

        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let point = createPointAnnotation(index: previewPoints.count, coordinate: coordinate)

        previewPoints.append(point)

        self.mapView.addAnnotation(point)
        self.previewPoints = previewPoints

        refreshPreviewPolygon()
    }

    private func createPointAnnotation(index: Int, coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let point = MKPreviewPointAnnotation()

        point.title = "Punkt \(index + 1)"
        point.coordinate = coordinate

        return point
    }

    public func refreshPreviewPolygon() {
        if let previousPolygon = previewPolygon {
            mapView.remove(previousPolygon)
        }

        guard let previewPoints = previewPoints else { return }
        guard previewPoints.count >= 3 else { return }

        let newPreview = MKPreviewPolygon(coordinates: previewPoints.map { $0.coordinate },
                                          count: previewPoints.count)

        self.mapView.add(newPreview)
        self.previewPolygon = newPreview
    }
}
