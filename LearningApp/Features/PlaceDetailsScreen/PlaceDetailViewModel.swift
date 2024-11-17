//
//  Untitled.swift
//  LearningApp
//
//  Created by Lucas Pinto on 17/11/24.
//

import Foundation

protocol PlaceDetailProtocol: PlaceDetailViewModelProtocol {
    var openExternalURL: ((URL) -> Void)? { get set }
}

final class PlaceDetailViewModel: PlaceDetailProtocol {

    var place: PlaceAnnotation
    var openExternalURL: ((URL) -> Void)?
    
    init(place: PlaceAnnotation) {
        self.place = place
    }
    
    func phoneButtonTapped() {
        guard let url = URL(string: "tel://\(place.phone)") else { return }
        openExternalURL?(url)
    }
    
    func directionsButtonTapped() {
        let coordinate = place.location.coordinate
        guard let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") else { return }
        openExternalURL?(url)
    }
}
