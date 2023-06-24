//
//  Order.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import Foundation

struct Order: Identifiable {
    var id = UUID()
    var date: Date
    var sum: Double
    var carName: String
}
