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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        step = try container.decode(String.self, forKey: .step)
        phone = try container.decode(String.self, forKey: .phone)
        success = try container.decode(Bool.self, forKey: .success)
    }
}


