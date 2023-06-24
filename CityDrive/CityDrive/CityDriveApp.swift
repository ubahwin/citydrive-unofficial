//
//  CityDriveApp.swift
//  CityDrive
//
//  Created by Иван Вдовин on 15.06.2023.
//

import SwiftUI

@main
struct CityDriveApp: App {
    let isLogged: Bool = false // TODO: refactor
    
    var body: some Scene {
        WindowGroup {
            if !isLogged {
                LoginView()
            } else {
                MapView(mapVM: MapViewModel())
            }
        }
    }
}
