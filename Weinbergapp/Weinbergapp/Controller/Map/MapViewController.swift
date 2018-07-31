//
//  MapViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//Ï

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!

    let fieldDataSource = RealmDataSource<Field>()
    
    var fields: [MapField] = []
    var previewer: MapPolygonDrawer!
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleAdd))
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggleAdd))

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.leftBarButtonItem = addButton

        mapView.delegate = self
        mapView.showsUserLocation = true

        previewer = MapPolygonDrawer(for: mapView)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        do {
            fields = try fieldDataSource.queryAll().map { field in
                let mapField = MapField(field: field, fieldDataSource: self.fieldDataSource, mapView: self.mapView)
                mapField.displayedOnMap = true
                return mapField
            }
        } catch let error as NSError {
            MapDialogs.presentLoadFailed(error: error, controller: self)
        }
    }

    @IBAction func toggleAdd(_ sender: UIBarButtonItem) {
        if previewer.isEnabled {
            if previewer.pointsDrawn < 3 {
                MapDialogs.presentInsufficientPointsWarning(controller: self, onCancel: { _ in
                    self.navigationBar.leftBarButtonItem = self.addButton
                    self.previewer.leavePreviewMode()
                })
            } else {
                let coordinates = previewer.getCoordinates()

                self.navigationBar.leftBarButtonItem = self.addButton
                self.previewer.leavePreviewMode()

                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                if let addField = storyboard.instantiateViewController(withIdentifier: "AddField")
                    as? AddFieldViewController {
                    addField.source = self
                    addField.coordinates = coordinates

                    self.present(addField, animated: true)
                }
            }
        } else {
            self.navigationBar.leftBarButtonItem = doneButton
            previewer.enterPreviewMode(coordinates: nil)
        }
    }

    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }

    @IBAction func currentLocation(_ sender: UIBarButtonItem) {
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        MapDialogs.presentLocationUnavailable(controller: self, error: error)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case let previewPointAnnotation as MKPreviewPointAnnotation:
            return previewPointAnnotation.getAnnotationView(in: mapView)
        case let fieldPointAnnotation as MKFieldPointAnnotation:
            return fieldPointAnnotation.getAnnotationView(in: mapView)
        default:
            break
        }

        return nil
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        switch view.annotation {
        case let point as MKPreviewPointAnnotation:
            previewer.remove(point: point)
        case let point as MKFieldPointAnnotation:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            if let editField = storyboard.instantiateViewController(withIdentifier: "AddField")
                as? AddFieldViewController {
                editField.source = self
                editField.editingField = point.owner!
                
                self.present(editField, animated: true)
            }
        default:
            break
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPreviewPolygon {
            return MKPreviewPolygon.makeRenderer(rendererFor: overlay)
        } else if overlay is MKFieldPolygon {
            return MKFieldPolygon.makeRenderer(rendererFor: overlay)
        }

        return MKOverlayRenderer()
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 didChange newState: MKAnnotationViewDragState,
                 fromOldState oldState: MKAnnotationViewDragState) {
        if newState == .ending {
            previewer.refreshPreviewPolygon()
        }
    }
}
