//
//  CityDriveApp.swift
//  CityDrive
//
//  Created by Иван Вдовин on 15.06.2023.
//

import SwiftUI

@main
struct CityDriveApp: App {
    #if DEBUG
    let isLogged: Bool = false
    #else
    let isLogged: Bool = false
    #endif
    
    var body: some Scene {
        WindowGroup {
            if !isLogged {
                LoginView()
            } else {
                MapView()
            }
        }
    }
}
