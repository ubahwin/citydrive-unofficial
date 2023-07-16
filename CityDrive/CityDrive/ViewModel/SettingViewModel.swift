//
//  SettingViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 01.07.2023.
//

import Foundation
import SwiftKeychainWrapper
import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var logged: Bool = UserDefaults.standard.bool(forKey: "isLogged")
    @Published var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    
    init() {
        logged = username == "" ? false : true
    }
    
    func exit() {
        withAnimation {
            logged = false
        }
        UserDefaults.standard.set("", forKey: "username")
        KeychainWrapper.standard.set("", forKey: "sessionID")
    }
}
