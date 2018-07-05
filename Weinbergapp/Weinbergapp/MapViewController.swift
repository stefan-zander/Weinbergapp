//
//  MapViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import MapKit

/*class Lol: MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var hash: Int
    
    var superclass: AnyClass?
    
    
    var description: String
    
    
    
    
    var title: String? = "Hi"
    var subtitle: String? = "jbjjbfj"
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(49.992862), longitude: CLLocationDegrees(8.247253))
    
    
}*/

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        
        mapView?.delegate = self
        mapView?.showsUserLocation = true
        
        let p1 = CLLocationCoordinate2D(latitude: 49.992862, longitude: 8.247253)
        let p2 = CLLocationCoordinate2D(latitude: 49.96674, longitude: 7.904596)
        let pts: [CLLocationCoordinate2D] = [p1, p2]
        
        let testline = MKPolyline(coordinates: pts, count: pts.count)
        
        mapView.addAnnotation(testline)
        
          
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

*/

}
