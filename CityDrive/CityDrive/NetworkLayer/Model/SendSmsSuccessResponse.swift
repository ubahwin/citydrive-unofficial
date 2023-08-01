//
//  SendSmsSuccessResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 24.06.2023.
//

import Foundation

struct SendSmsSuccessResponse: Codable {
    let sessionID: String?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case success
    }
}

