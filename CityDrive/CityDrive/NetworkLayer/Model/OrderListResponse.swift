//
//  OrderListResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct OrderListResponse: Codable {
    let orders: [OrderResponse]?
    let user: UserOrdersResponse?
    let count: Int?
    let success: Bool?
}

struct OrderResponse: Codable {
    let orderID, startedAt, amount: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case startedAt = "started_at"
        case amount
    }
}

struct UserOrdersResponse: Codable {
    let firstName, lastName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
