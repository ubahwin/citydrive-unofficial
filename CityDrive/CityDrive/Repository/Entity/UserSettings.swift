//
//  UserSettings.swift
//  CityDrive
//
//  Created by Иван Вдовин on 25.09.2023.
//

import Foundation

struct UserSettings {
    var isLogged: Bool

    var city: City
    var mapType: MapType
    var theme: Theme
    var mapInteractions: [MapInteraction]
}
