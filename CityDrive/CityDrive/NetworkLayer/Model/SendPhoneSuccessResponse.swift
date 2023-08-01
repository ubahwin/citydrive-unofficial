//
//  SendPhoneSuccessResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 24.06.2023.
//

import Foundation

struct SendPhoneSuccessResponse: Codable {
    let step, phone: String?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case step, phone, success
    }
}
