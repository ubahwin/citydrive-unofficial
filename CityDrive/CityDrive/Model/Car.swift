//
//  Car.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import Foundation
import MapKit

struct Car: Identifiable {
    var id: UUID
    var name: String
    var coordinate: CLLocationCoordinate2D
}
