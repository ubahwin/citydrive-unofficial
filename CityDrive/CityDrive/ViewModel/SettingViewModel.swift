//
//  SettingViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 01.07.2023.
//

import Foundation
import SwiftKeychainWrapper
import SwiftUI
import _MapKit_SwiftUI

class SettingViewModel: ObservableObject {
    private var networkManager: NetworkManager

    @Published var logged: Bool?
    @Published var user: User?
    @Published var selectedInteractions: [String] {
        didSet {
            UserDefaults.standard.set(selectedInteractions, forKey: "selectedInteractions")
        }
    }
    @State var interactions: [MapInteraction] = MapInteraction.allCases

    @AppStorage("isDarkTheme") var isDarkTheme = true
    @AppStorage("selectedCity") var сity: City = .spb
    @AppStorage("selectedMapType") var mapType: MapType = .standard

    init() {
        self.networkManager = NetworkManager()

        logged = UserDefaults.standard.bool(forKey: "isLogged")
        selectedInteractions = UserDefaults.standard.stringArray(forKey: "selectedInteractions") ?? []

        loadUser()
    }

    func exit() {
        withAnimation {
            logged = false
        }
        UserDefaults.standard.set(false, forKey: "isLogged")
        UserDefaults.standard.set("", forKey: "username")
        KeychainWrapper.standard.set("", forKey: "sessionID")
    }

    // swiftlint:disable function_body_length
    func loadUser() {
        networkManager.getUser { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let userResponse = response {
                let achievements = userResponse.ratingV2?.achievements?.compactMap { achievement in
                    if
                        let localeName = achievement.localeName,
                        let achievementID = achievement.achievementID,
                        let id = UUID(uuidString: achievementID) {
                        return UserAchievement(id: id, localeName: localeName)
                    }
                    return nil
                }

                let user = User(
                    userID: userResponse.userID ?? "",
                    firstName: userResponse.firstName ?? "",
                    lastName: userResponse.lastName ?? "",
                    avatar: userResponse.avatar ?? "",
                    gender: userResponse.gender == "male" ? .male : .female,
                    email: userResponse.email ?? "",
                    phone: userResponse.phone ?? 0,
                    bonus: userResponse.bonus ?? 0,
                    debt: userResponse.debt ?? 0,
                    rating: userResponse.rating ?? 0,
                    level: userResponse.level ?? 0,
                    ratingV2: UserRatingV2(
                        rating: userResponse.ratingV2?.rating ?? 0,
                        level: userResponse.ratingV2?.level ?? 0,
                        ratingV2Level: userResponse.ratingV2?.ratingV2Level ?? 0,
                        achievements: achievements ?? [],
                        levelNext: UserLevelNext(
                            number: userResponse.ratingV2?.levelNext?.number ?? 0,
                            levelNextNumber: userResponse.ratingV2?.levelNext?.levelNextNumber ?? 0,
                            rating: userResponse.ratingV2?.levelNext?.rating ?? 0,
                            trips: userResponse.ratingV2?.levelNext?.trips ?? 0,
                            days: userResponse.ratingV2?.levelNext?.days ?? 0
                        ),
                        levelX0UpdatedAt: userResponse.ratingV2?.levelX0UpdatedAt ?? ""
                    ),
                    referralCode: userResponse.referralCode ?? "",
                    sendPush: userResponse.sendPush ?? false,
                    userCorporateRoleID: userResponse.userCorporateRoleID ?? "",
                    subscriptionStatus: userResponse.subscriptionStatus ?? "",
                    isRiskProfileEnabled: userResponse.isRiskProfileEnabled ?? false,
                    card: UserCard(
                        number: userResponse.card?.number ?? ""
                    )
                )

                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
    // swiftlint:enable function_body_length
}
