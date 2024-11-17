//
//  PlaceDetailsFactory.swift
//  LearningApp
//
//  Created by Lucas Pinto on 16/11/24.
//

import UIKit

final class PlaceDetailsFactory {
    static func build(place: PlaceAnnotation) -> UIViewController {
        let view = PlaceDetailView()
        let viewModel = PlaceDetailViewModel(place: place)
        let viewController = PlaceDetailViewController(place: place, placeView: view, viewModel: viewModel)
        return viewController
    }
}
