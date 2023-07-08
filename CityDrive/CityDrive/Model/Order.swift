//
//  Order.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct Order: Identifiable {
    var id: UUID
    var amount: Double
    
    var car: Car
    var locationStart, locationFinish: Location
}

struct Location {
    let timestamp, address: String
    let lat, lon: Double
}
