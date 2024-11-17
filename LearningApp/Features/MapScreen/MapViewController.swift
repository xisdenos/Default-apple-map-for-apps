//
//  ViewController.swift
//  LearningApp
//
//  Created by Lucas Pinto on 06/11/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var viewModel: MapProtocol
    private var mapScreenView: MapView
    private var mapAdapter: MapAdapterProtocol
    
    // MARK: - Init
    
    init(mapViewModel: MapProtocol, mapScreenView: MapView, mapAdapter: MapAdapterProtocol) {
        self.viewModel = mapViewModel
        self.mapScreenView = mapScreenView
        self.mapAdapter = mapAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller life cycle
    
    override func loadView() {
        super.loadView()
        self.view = mapScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapAdapter.setDelegate(delegate: self)
        mapAdapter.requestAuthorization()
        bindIn()
    }
    
    private func bindIn() {
        mapScreenView.bind(viewModel: viewModel)
        
        viewModel.onPresentTableViewSheet = { [weak self] locationTableViewCell, annotationList in
            self?.present(locationTableViewCell, animated: true)
            self?.mapScreenView.mapScreen.addAnnotations(annotationList)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        mapAdapter.checkLocationAuthorization { [weak self] result in
            switch result {
            case .success(let region):
                guard let self else { return }
                self.mapScreenView.mapScreen.setRegion(region, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}

