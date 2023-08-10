//
//  CityDriveApp.swift
//  CityDrive
//
//  Created by Иван Вдовин on 15.06.2023.
//

import SwiftUI

@main
struct CityDriveApp: App {
    private var isLogged = UserDefaults.standard.bool(forKey: "isLogged")
    @AppStorage("isDarkTheme") var isDarkTheme: Bool?
            
    var body: some Scene {
        WindowGroup {
            if !isLogged {
                LoginView()
            } else {
                ContentView()
                    .preferredColorScheme(isDarkTheme ?? true ? .dark : .light)
            }
        }
    }
}
