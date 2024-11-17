//
//  LocationsTableViewCell.swift
//  LearningApp
//
//  Created by Lucas Pinto on 15/11/24.
//

import MapKit

class LocationsTableViewCell: UITableViewController {
    
    static let identifier: String = "PlaceCell"
    var userLocation: CLLocation
    var places: [PlaceAnnotation]
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.userLocation = userLocation
        self.places = places
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
        self.places.swapAt(selectedRowIndex ?? 0, 0)
    }
    
    private var selectedRowIndex: Int? {
        self.places.firstIndex(where: { $0.isSelected == true })
    }
    
    private func calculateFormattedLocationDistance(from: CLLocation, to: CLLocation) -> String {
        return from.distance(from: to).formattedDistanceInKilometers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        present(PlaceDetailsFactory.build(place: place), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = place.name
        content.secondaryText = calculateFormattedLocationDistance(from: userLocation, to: place.location)
        
        cell.contentConfiguration = content
        cell.backgroundColor = place.isSelected ? UIColor.red : .white
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
