//
//  PlaceDetailViewController.swift
//  LearningApp
//
//  Created by Lucas Pinto on 16/11/24.
//

import Foundation
import UIKit

final class PlaceDetailViewController: UIViewController {
    
    private var place: PlaceAnnotation
    private var placeView: PlaceDetailView
    private var viewModel: PlaceDetailProtocol
    
    init(place: PlaceAnnotation, placeView: PlaceDetailView, viewModel: PlaceDetailProtocol) {
        self.viewModel = viewModel
        self.place = place
        self.placeView = placeView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = placeView
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        bindIn()
    }
    
    private func bindIn() {
        self.placeView.bind(viewModel: viewModel)
        
        self.viewModel.openExternalURL = { [weak self] url in
            UIApplication.shared.open(url)
        }
    }
    
}
