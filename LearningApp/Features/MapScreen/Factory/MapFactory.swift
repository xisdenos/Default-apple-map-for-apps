//
//  MapFactory.swift
//  LearningApp
//
//  Created by Lucas Pinto on 08/11/24.
//

import UIKit
import MapKit

final class MapFactory {
    static func build() -> UIViewController {
        let locationManager = CLLocationManager()
        let viewModel = MapViewModel(locationManager: locationManager)
        let view = MapView()
        let adapter = MapAdapter(locationManager: locationManager)
        return MapViewController(mapViewModel: viewModel, mapScreenView: view, mapAdapter: adapter)
    }
}
