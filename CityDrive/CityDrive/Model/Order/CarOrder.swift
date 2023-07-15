//
//  CarOrder.swift
//  CityDrive
//
//  Created by Иван Вдовин on 13.07.2023.
//

import Foundation

struct CarOrder {
    var id, number, model, img: String
    var odometer: Odometer
}
struct Odometer {
    var atStart, atFinish: Int
}
