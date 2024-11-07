//
//  ViewController.swift
//  LearningApp
//
//  Created by Lucas Pinto on 06/11/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var mapScreenView: MapView = MapView()
    
    override func loadView() {
        super.loadView()
        self.view = mapScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}

