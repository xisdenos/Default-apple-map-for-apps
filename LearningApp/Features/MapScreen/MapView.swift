//
//  MapView.swift
//  LearningApp
//
//  Created by Lucas Pinto on 06/11/24.
//

import UIKit
import MapKit

protocol MapViewModelProtocol {
    func findNearbyPlaces(by query: String, region: MKCoordinateRegion)
    func presentPlacesSheet(places: [PlaceAnnotation])
    func clearAllSelectedPlaces()
    
    var placeList: [PlaceAnnotation] { get }
}

final class MapView: UIView {
    
    private var viewModel: MapViewModelProtocol?
    
    func bind(viewModel: MapViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    lazy var mapScreen: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = self
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for a location"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - SuperView
    
    private func configureSuperView() {
        addSubview(mapScreen)
        addSubview(searchTextField)
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSuperView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Constraints

extension MapView {
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mapScreen.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapScreen.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mapScreen.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mapScreen.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: mapScreen.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: mapScreen.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: mapScreen.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

//MARK: - Delegates

extension MapView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let text = textField.text ?? ""
        if !text.isEmpty {
            textField.resignFirstResponder()
            mapScreen.removeAnnotations(mapScreen.annotations)
            viewModel?.findNearbyPlaces(by: text, region: mapScreen.region)
        }
        
        return true
    }
}

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        
        self.viewModel?.clearAllSelectedPlaces()
        
        guard let selectedPlace = annotation as? PlaceAnnotation else { return }
        let placeAnnotation = self.viewModel?.placeList.first(where: { $0.id == selectedPlace.id })
        placeAnnotation?.isSelected = true
        
        self.viewModel?.presentPlacesSheet(places: self.viewModel?.placeList ?? [PlaceAnnotation(mapItem: MKMapItem())])
        
    }
}

