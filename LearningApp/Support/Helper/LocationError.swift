//
//  LocationError.swift
//  LearningApp
//
//  Created by Lucas Pinto on 11/11/24.
//

import Foundation

enum LocationError: Error {
    case notAbleToLocate
    case deniedAuthorization
    case notDeterminedAccess
    case unknownAuthorizationStatus
}

extension LocationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notAbleToLocate:
            return "Unable to locate your user. Please check your internet connection and try again."
        case .deniedAuthorization:
            return "Authorization to access location services has been denied. Please enable it in your settings."
        case .notDeterminedAccess:
            return "Location access status has not been determined yet. Please check your permissions."
        case .unknownAuthorizationStatus:
            return "An unknown error occurred while determining location access status."
        }
    }
}
