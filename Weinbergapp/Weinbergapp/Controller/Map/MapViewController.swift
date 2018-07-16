//
//  MapViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var add: UIBarButtonItem!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var currentPolygon: [CLLocationCoordinate2D]?
    let locationManager = CLLocationManager()
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        if currentPolygon == nil {
            currentPolygon = []
            add.title = "Fertig"
            mapView.isUserInteractionEnabled = false
        } else {
            if currentPolygon!.count >= 3 {
                currentPolygon!.append(currentPolygon![0])
                let polygon = MKPolygon(coordinates: currentPolygon!, count: currentPolygon!.count)
                mapView.add(polygon)
            }
            
            currentPolygon = nil
            add.title = "Hinzufügen"
            mapView.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isUserInteractionEnabled = false
        
        /*let l1 = CLLocationCoordinate2D(latitude: 49.992862, longitude: 8.247253)
        let l2 = CLLocationCoordinate2D(latitude: 49.96674, longitude: 7.904596)
        let l3 = CLLocationCoordinate2D(latitude: 49.94674, longitude: 7.954596)
        
        let pts: [CLLocationCoordinate2D] = [ l1, l2, l3, l1 ]
        
        let testline = MKPolygon(coordinates: pts, count: pts.count)
        
        let p1 = MKPointAnnotation()
        p1.coordinate = l1
        
        let p2 = MKPointAnnotation()
        p2.coordinate = l2
        
        let p3 = MKPointAnnotation()
        p3.coordinate = l3
        
        mapView.add(testline)
        mapView.addAnnotations([p1, p2, p3])*/
        
        
        
          
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentPolygon != nil {
            mapView.removeOverlays(mapView.overlays)
            
            if let touch = touches.first {
                let coordinate = mapView.convert(touch.location(in: mapView), toCoordinateFrom: mapView)
                
                self.currentPolygon?.append(coordinate)
                
                let point = MKPointAnnotation()
                point.coordinate = coordinate
                mapView.addAnnotation(point)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(overlay: overlay)
            
            renderer.fillColor = UIColor.blue.withAlphaComponent(0.25)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.5)
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }

    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
          default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
