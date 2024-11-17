//
//  MapKitHandler.swift
//  LearningApp
//
//  Created by Lucas Pinto on 07/11/24.
//

import MapKit
import Foundation

protocol MapAdapterProtocol {
    func setDelegate(delegate: CLLocationManagerDelegate)
    func requestAuthorization()
    func checkLocationAuthorization(completion: @escaping (Result<MKCoordinateRegion, LocationError>) -> Void)
    
    
}

class MapAdapter: NSObject, MapAdapterProtocol {
    
    private var locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
    }
    
    func setDelegate(delegate: CLLocationManagerDelegate) {
        locationManager.delegate = delegate
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        print()
    }
    
    func checkLocationAuthorization(completion: @escaping (Result<MKCoordinateRegion, LocationError>) -> Void) {
        guard let location = locationManager.location else { return completion(.failure(.notAbleToLocate)) }
        
        switch locationManager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            let userRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
            return completion(.success(userRegion))
        case .denied:
            return completion(.failure(.deniedAuthorization))
        case .notDetermined, .restricted:
            return completion(.failure(.notDeterminedAccess))
        default :
            return completion(.failure(.unknownAuthorizationStatus))
        }
    }
}
