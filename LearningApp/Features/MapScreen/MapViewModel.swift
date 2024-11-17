//
//  MapViewModel.swift
//  LearningApp
//
//  Created by Lucas Pinto on 06/11/24.
//

import Foundation
import MapKit

protocol MapProtocol: MapViewModelProtocol {
    var onPresentTableViewSheet: ((LocationsTableViewCell, [MKAnnotation]) -> Void)? { get set }
}

final class MapViewModel: MapProtocol {
    
    // MARK: - Public properties
    
    var onPresentTableViewSheet: ((LocationsTableViewCell, [MKAnnotation]) -> Void)?
    var placeList: [PlaceAnnotation] = []
    
    // MARK: - Private properties
    
    private var locationManager: CLLocationManager
    
    // MARK: - Init
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
    }
    
    func presentPlacesSheet(places: [PlaceAnnotation]) {
        
        guard let location = locationManager.location else { return }
        
        let placesTVC = LocationsTableViewCell(userLocation: location, places: places)
        placesTVC.modalPresentationStyle = .pageSheet
        
        if let sheet = placesTVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .large()]
            onPresentTableViewSheet?(placesTVC, places)
        }
    }
    
    func findNearbyPlaces(by query: String, region: MKCoordinateRegion) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, error == nil else { return }
            self.placeList = response.mapItems.map(PlaceAnnotation.init)
            self.presentPlacesSheet(places: self.placeList)
        }
    }
    
    func clearAllSelectedPlaces() {
        self.placeList = self.placeList.map { place in
            place.isSelected = false
            return place
        }
    }
}
