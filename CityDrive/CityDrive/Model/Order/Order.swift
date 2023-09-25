//
//  Order.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct Order {
    // Стоимость за использование
    var usageCost: Double
    // Итого
    var totalCost: Double
    var parkingCost: Double

    // Число списанных бонусов
    var bonusCancellationAmount: Double?
    // Число начисленных бонусов
    var bonusAccrualAmount: Double?

    var car: CarOrder
    var events: [EventOrder]
    var path: PathOrder
    var user: UserOrder
    var otherInfo: OtherInfoOrder
}
