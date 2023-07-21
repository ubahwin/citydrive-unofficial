//
//  BonusCountResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 18.07.2023.
//

import Foundation

struct BonusBalanceResponse: Codable {
    var balance: Int?
    
    enum CodingKeys: String, CodingKey {
        case balance
    }
}
