//
//  MapView.swift
//  LearningApp
//
//  Created by Lucas Pinto on 06/11/24.
//

import UIKit
import MapKit

final class MapView: UIView {
    
    lazy var mapScreen: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
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

