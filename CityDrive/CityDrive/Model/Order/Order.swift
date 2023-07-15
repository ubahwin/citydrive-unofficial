//
//  Order.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct Order {
    var usageCost: Double
    var car: CarOrder
    var events: [EventOrder]
    var path: PathOrder
    var user: UserOrder
    var otherInfo: OtherInfoOrder
}
