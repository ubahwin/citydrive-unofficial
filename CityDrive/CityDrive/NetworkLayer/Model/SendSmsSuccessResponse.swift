//
//  SendSmsSuccessResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 24.06.2023.
//

import Foundation

struct SendSmsSuccessResponse: Decodable {
    let sessionID: String
    let user: SmsSuccessUserResponse
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case user, success
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sessionID = try container.decode(String.self, forKey: .sessionID)
        user = try container.decode(SmsSuccessUserResponse.self, forKey: .user)
        success = try container.decode(Bool.self, forKey: .success)
    }
}

struct SmsSuccessUserResponse: Decodable {
    let userID, phone, email, firstName, middleName, lastName, avatar: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case phone, email
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case avatar
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userID = try container.decode(String.self, forKey: .userID)
        phone = try container.decode(String.self, forKey: .phone)
        email = try container.decode(String.self, forKey: .email)
        firstName = try container.decode(String.self, forKey: .firstName)
        middleName = try container.decode(String.self, forKey: .middleName)
        lastName = try container.decode(String.self, forKey: .lastName)
        avatar = try container.decode(String.self, forKey: .avatar)
    }
}
