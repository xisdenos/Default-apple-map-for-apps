//
//  MapKit + Distance.swift
//  LearningApp
//
//  Created by Lucas Pinto on 15/11/24.
//

import MapKit

extension CLLocationDistance {
    
    func formattedDistanceInKilometers() -> String {
        return Measurement(value: self, unit: UnitLength.kilometers).formatted()
    }
}
