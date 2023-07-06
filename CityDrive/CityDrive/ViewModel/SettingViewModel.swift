//
//  SettingViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 01.07.2023.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var logged: Bool = false
    @Published var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    
    init() {
        logged = username == "" ? false : true
    }
}
