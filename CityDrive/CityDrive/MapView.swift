//
//  ContentView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 15.06.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapVM = MapViewModel()

    var body: some View {
        TabView {
            Group {
                ZStack {
                    Map {
                        ForEach(mapVM.cars) { car in
                            Annotation(car.name, coordinate: car.coordinate) {
                                Pin()
                            }
                        }
                    }
                    .mapControls {
                        MapCompass()
                        MapPitchButton()
                        MapUserLocationButton()
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                mapVM.goToMyLocation()
                            }, label: {
                                MyLocationButton()
                            })
                                .padding()
                        }
                    }
                }
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
    MapView()
}
