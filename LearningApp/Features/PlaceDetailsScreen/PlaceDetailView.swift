//
//  PlaceDetailView.swift
//  LearningApp
//
//  Created by Lucas Pinto on 16/11/24.
//

import UIKit

protocol PlaceDetailViewModelProtocol {
    func phoneButtonTapped()
    func directionsButtonTapped()
    
    var place: PlaceAnnotation { get }
}

final class PlaceDetailView: UIView {
    
    private var viewModel: PlaceDetailViewModelProtocol?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.alpha = 0.4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var directionsButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.bordered())
        button.setTitle("Directions", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var callButton: UIButton = {
        
        var config = UIButton.Configuration.bordered()
        let button = UIButton(configuration: config)
        button.setTitle("Call", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func configureSuperView() {
        addSubview(directionsButton)
        addSubview(callButton)
        setupUI()
    }
    
    private func setupVariabels() {
        nameLabel.text = self.viewModel?.place.name
        addressLabel.text = self.viewModel?.place.address
    }
    
    func bind(viewModel: PlaceDetailViewModelProtocol?) {
        self.viewModel = viewModel
        setupVariabels()
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureSuperView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func directionsButtonTapped(_ sender: UIButton) {
        self.viewModel?.directionsButtonTapped()
    }
    
    @objc func callButtonTapped(_ sender: UIButton) {
        self.viewModel?.phoneButtonTapped()
    }
    
    private func setupUI() {
        
        let stackView = PlaceAnnotationStackView(frame: CGRect(), name: nameLabel, address: addressLabel)
        let contactStackView = UIStackView()
        contactStackView.translatesAutoresizingMaskIntoConstraints = false
        contactStackView.axis = .horizontal
        contactStackView.spacing = UIStackView.spacingUseSystem
        
        directionsButton.addTarget(self, action: #selector(directionsButtonTapped), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        
        contactStackView.addArrangedSubview(directionsButton)
        contactStackView.addArrangedSubview(callButton)
        
        stackView.addArrangedSubview(contactStackView)
        
        self.addSubview(stackView)
    }
}

extension PlaceDetailView {
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - 20)
        ])
    }
}
