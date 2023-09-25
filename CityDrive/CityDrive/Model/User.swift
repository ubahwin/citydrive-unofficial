//
//  User.swift
//  CityDrive
//
//  Created by Иван Вдовин on 21.07.2023.
//

import Foundation

struct User {
    var userID, firstName, lastName: String
    var avatar: String
    var gender: UserGender
    var email: String
    var phone, bonus, debt, rating: Int
    var level: Int
    var ratingV2: UserRatingV2
    var referralCode: String
    var sendPush: Bool
    var userCorporateRoleID: String
    var subscriptionStatus: String
    var isRiskProfileEnabled: Bool
    var card: UserCard
}

enum UserGender {
    case male, female

    var title: String {
        switch self {
        case .female: return "Женщина"
        case .male: return "Мужчина"
        }
    }
}

struct UserCard {
    var number: String
}

struct UserRatingV2 {
    var rating, level, ratingV2Level: Int
    var achievements: [UserAchievement]
    var levelNext: UserLevelNext
    var levelX0UpdatedAt: String
}

struct UserAchievement: Identifiable {
    var id: UUID
    var localeName: String
}

struct UserLevelNext {
    var number, levelNextNumber, rating, trips: Int
    var days: Int
}
