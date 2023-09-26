//
//  UserDefaultsRepository.swift
//  CityDrive
//
//  Created by Иван Вдовин on 25.09.2023.
//

import Foundation

class UserDefaultsRepository: RepositoryProtocol {
    func create(entity: UserSettings) {
//        UserDefaults.standard
    }

    func read() -> UserSettings? {
        let isLogged = false
        let city: City = .moscow
        let mapType: MapType = .hybrid
        let theme: Theme = .dark
        let mapInteractions: [MapInteraction] = [.pan, .pitch, .rotate, .zoom]

        let settings = UserSettings(
            isLogged: isLogged,
            city: city,
            mapType: mapType,
            theme: theme,
            mapInteractions: mapInteractions
        )
        return settings
    }

    func update(entity: UserSettings) {
        //
    }

    func delete(entity: UserSettings) {
        //
    }
}
