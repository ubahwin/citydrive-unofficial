//
//  Path.swift
//  CityDrive
//
//  Created by Иван Вдовин on 13.07.2023.
//

import Foundation

struct PathOrder {
    var start, finish: LocateOrder
    var period: PeriodOrder
}

struct LocateOrder {
    var lat, lon: Double
}

struct PeriodOrder {
    var start, finish: String
}
