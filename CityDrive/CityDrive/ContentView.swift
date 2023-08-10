//
//  ContentView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 15.06.2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Карта")
                    }
                OrderListView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                        Text("История поездок")
                    }
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Настройки")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
        .accentColor(.green)
    }
}

#Preview {
    ContentView()
}
