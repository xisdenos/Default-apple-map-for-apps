//
//  DefaultStackView.swift
//  LearningApp
//
//  Created by Lucas Pinto on 16/11/24.
//

import UIKit

class PlaceAnnotationStackView: UIStackView {
    
    init(frame: CGRect, name: UILabel, address: UILabel) {
        super.init(frame: frame)
        self.addArrangedSubview(name)
        self.addArrangedSubview(address)
        setupByStyle()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupByStyle() {
        self.alignment = .leading
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = UIStackView.spacingUseSystem
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    }
}
