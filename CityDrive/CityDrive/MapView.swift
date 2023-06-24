//
//  ContentView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 15.06.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapVM: MapViewModel
    
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
                
                OrderListView(orders: [
                    Order(date: Date(), sum: 54.1, carName: "nisan"),
                    Order(date: Date(), sum: 65, carName: "motiz")
                ])
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Поездки")
                }
                
                SettingView(name: "Иван")
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
    MapView(mapVM: MapViewModel())
}
