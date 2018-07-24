//
//  MapViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!
    var previewer: PolygonDrawer!

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleAdd))
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggleAdd))

    let locationManager = CLLocationManager()
    var fields: [MKFieldPolygon] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.leftBarButtonItem = addButton

        mapView.delegate = self
        mapView.showsUserLocation = true

        previewer = PolygonDrawer(for: mapView)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        /*let annotation = MKPointAnnotation()
         annotation.coordinate = CLLocationCoordinate2D(latitude: 49.966740, longitude: 7.904596)  // your location here
         annotation.title = "My Title"
         annotation.subtitle = "My Subtitle"

         self.mapView.addAnnotation(annotation)*/
    }

    @IBAction func toggleAdd(_ sender: UIBarButtonItem) {
        if previewer.isEnabled {
            if previewer.pointsDrawn < 3 {
                let alert = UIAlertController(title: "Nicht genügend Punkte eingezeichnet",
                                              message: "Um eine Fläche aufzuspannen werden mindestens drei Punkte " +
                                                       "benötigt.",
                                              preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Weitere Punkte einzeichnen", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Vorgang abbrechen", style: .cancel, handler: { _ in
                    self.navigationBar.leftBarButtonItem = self.addButton
                    self.previewer.leavePreviewMode()
                }))

                self.present(alert, animated: true)
                return
            }

            // add it

            self.navigationBar.leftBarButtonItem = addButton
            previewer.leavePreviewMode()
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
        let alert = UIAlertController(title: "Standort konnte nicht ermittelt werden.",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            if let pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") {
                pinAnnotationView.annotation = annotation
                return pinAnnotationView
            } else {
                let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")

                pinAnnotationView.pinTintColor = .blue
                pinAnnotationView.isDraggable = true
                pinAnnotationView.canShowCallout = true
                pinAnnotationView.animatesDrop = true

                let removeButton = UIButton(type: .detailDisclosure)
                removeButton.setImage(UIImage(named: "trash"), for: .normal)
                pinAnnotationView.rightCalloutAccessoryView = removeButton

                return pinAnnotationView
            }
        }

        return nil
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        if let point = view.annotation as? MKPointAnnotation {
            previewer.remove(point: point)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(overlay: overlay)

            renderer.fillColor = UIColor.blue.withAlphaComponent(0.25)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.5)
            renderer.lineWidth = 2
            renderer.lineDashPattern = [8, 8]

            return renderer
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
