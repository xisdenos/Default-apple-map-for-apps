//
//  MapKitHandler.swift
//  LearningApp
//
//  Created by Lucas Pinto on 07/11/24.
//

import MapKit
import Foundation

protocol MapAdapterProtocol {
    func requestAuthorization()
}

class MapAdapter: NSObject, MapAdapterProtocol {
    
    var locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension MapAdapter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}

