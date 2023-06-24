//
//  MapViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var cars: [Car] = []
    
    init() {
        let cars = [
            Car(id: UUID(), name: "reno", coordinate: CLLocationCoordinate2D(latitude: 59.901153, longitude: 30.274750)),
            Car(id: UUID(), name: "nissan", coordinate: CLLocationCoordinate2D(latitude: 59.902153, longitude: 30.214750)),
            Car(id: UUID(), name: "motiz", coordinate: CLLocationCoordinate2D(latitude: 59.904153, longitude: 30.294750))
        ]
        self.cars = cars
    }
    
    func goToMyLocation() {
        
    }
}
