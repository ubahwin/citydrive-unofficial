//
//  FullUserResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 21.07.2023.
//

import Foundation

struct FullUserResponse: Codable {
    let userID, firstName, lastName: String?
    let avatar: String?
    let gender: String?
    let email: String?
    let phone, bonus, debt, rating: Int?
    let level: Int?
    let ratingV2: RatingV2UserResponse?
    let referralCode: String?
    let sendPush: Bool?
    let userCorporateRoleID: String?
    let subscriptionStatus: String?
    let isRiskProfileEnabled: Bool?
    let card: CardUserResponse?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar, gender
        case email, phone, bonus, debt, rating, level
        case ratingV2 = "rating_v2"
        case referralCode = "referral_code"
        case sendPush = "send_push"
        case userCorporateRoleID = "user_corporate_role_id"
        case subscriptionStatus = "subscription_status"
        case isRiskProfileEnabled, card
    }
}

struct CardUserResponse: Codable {
    let number: String?

    enum CodingKeys: String, CodingKey {
        case number
    }
}

struct RatingV2UserResponse: Codable {
    let rating, level, ratingV2Level: Int?
    let achievements: [AchievementUserResponse]?
    let levelNext: LevelNextUserResponse?
    let levelX0UpdatedAt: String?

    enum CodingKeys: String, CodingKey {
        case rating
        case level = "_level"
        case ratingV2Level = "level"
        case achievements
        case levelNext = "level_next"
        case levelX0UpdatedAt
    }
}

struct AchievementUserResponse: Codable {
    let achievementID: String?
    let localeName: String?

    enum CodingKeys: String, CodingKey {
        case localeName = "locale_name"
        case achievementID = "achievement_id"
    }
}

struct LevelNextUserResponse: Codable {
    let number, levelNextNumber, rating, trips: Int?
    let days: Int?

    enum CodingKeys: String, CodingKey {
        case number = "_number"
        case levelNextNumber = "number"
        case rating, trips, days
    }
}
