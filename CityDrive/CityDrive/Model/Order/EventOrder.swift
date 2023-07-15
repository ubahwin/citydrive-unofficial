//
//  EventOrder.swift
//  CityDrive
//
//  Created by Иван Вдовин on 13.07.2023.
//

import Foundation

struct EventOrder {
    var state, name, status, time: String
    var lat, lon: Double
    var isPassive: Bool
    var cost: Int
    var duration: Double
    var userLat, userLon: Double
}
