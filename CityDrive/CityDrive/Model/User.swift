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

extension FullUserResponse {
    func mapToUser() -> User {
        let achievements = self.ratingV2?.achievements?.compactMap { achievement in
            if
                let localeName = achievement.localeName,
                let achievementID = achievement.achievementID,
                let id = UUID(uuidString: achievementID) {
                return UserAchievement(id: id, localeName: localeName)
            }
            return nil
        }

        let user = User(
            userID: self.userID ?? "",
            firstName: self.firstName ?? "",
            lastName: self.lastName ?? "",
            avatar: self.avatar ?? "",
            gender: self.gender == "male" ? .male : .female,
            email: self.email ?? "",
            phone: self.phone ?? 0,
            bonus: self.bonus ?? 0,
            debt: self.debt ?? 0,
            rating: self.rating ?? 0,
            level: self.level ?? 0,
            ratingV2: UserRatingV2(
                rating: self.ratingV2?.rating ?? 0,
                level: self.ratingV2?.level ?? 0,
                ratingV2Level: self.ratingV2?.ratingV2Level ?? 0,
                achievements: achievements ?? [],
                levelNext: UserLevelNext(
                    number: self.ratingV2?.levelNext?.number ?? 0,
                    levelNextNumber: self.ratingV2?.levelNext?.levelNextNumber ?? 0,
                    rating: self.ratingV2?.levelNext?.rating ?? 0,
                    trips: self.ratingV2?.levelNext?.trips ?? 0,
                    days: self.ratingV2?.levelNext?.days ?? 0
                ),
                levelX0UpdatedAt: self.ratingV2?.levelX0UpdatedAt ?? ""
            ),
            referralCode: self.referralCode ?? "",
            sendPush: self.sendPush ?? false,
            userCorporateRoleID: self.userCorporateRoleID ?? "",
            subscriptionStatus: self.subscriptionStatus ?? "",
            isRiskProfileEnabled: self.isRiskProfileEnabled ?? false,
            card: UserCard(
                number: self.card?.number ?? ""
            )
        )

        return user
    }
}
