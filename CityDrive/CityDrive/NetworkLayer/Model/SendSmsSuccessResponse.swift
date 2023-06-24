//
//  SendSmsSuccessResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 24.06.2023.
//

import Foundation

struct SendSmsSuccessResponse: Codable {
    let sessionID, step, regVersion, countryLevel: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case step, regVersion, countryLevel, success
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sessionID = try container.decode(String.self, forKey: .sessionID)
        step = try container.decode(String.self, forKey: .step)
        regVersion = try container.decode(String.self, forKey: .regVersion)
        countryLevel = try container.decode(String.self, forKey: .countryLevel)
        success = try container.decode(Bool.self, forKey: .success)
    }
}
