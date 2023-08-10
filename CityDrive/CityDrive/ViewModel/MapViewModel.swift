//
//  MapViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    private var networkManager: NetworkManager
    
    @Published var carsIsLoaded = false
    @Published var cars: [MKMapItem] = []
    @Published var bonusBalance = ""
    
    // Settings
    @AppStorage("selectedCity") var city: City?
    @AppStorage("selectedMapType") var mapType: MapType?
    var interactions: MapInteractionModes {
        let stringInteraction = UserDefaults.standard.stringArray(forKey: "selectedInteractions") ?? []
        let mapInteractions: [MapInteraction] = stringInteraction.compactMap { MapInteraction.fromString($0) }
        var mapInteractionModes: MapInteractionModes = []
        for interaction in mapInteractions {
            mapInteractionModes.insert(interaction.mapValue)
        }
        return mapInteractionModes
    }

    init() {
        self.networkManager = NetworkManager()
        loadCarStatus()
    }
    
    func loadCarStatus() {
        networkManager.getCarStatus { response, error in
            if let error = error {
                print(error)
            }

            if let statusResponse = response {
                let cars = statusResponse.cars?.compactMap { car in
                    if
                        car.areaGroupID == self.city?.areaGroupID,
                        let carID = car.carID,
                        let id = UUID(uuidString: carID),
                        let lat = car.lat,
                        let lon = car.lon,
                        let img = car.img,
                        let model = car.model,
                        let number = car.number,
                        let distance = car.distance,
                        let walktime = car.walktime,
                        let fuel = car.fuel,
                        let tankVolume = car.tankVolume,
                        let powerReserve = car.powerReserve,
                        let seats = car.seats,
                        let remainPath = car.remainPath,
                        let hasTransponder = car.hasTransponder,
                        let boosterSeat = car.boosterSeat,
                        let babySeat = car.babySeat,
                        let forSale = car.forSale,
                        let engineWarnUpAvailable = car.engineWarnUpAvailable,
                        let isElectric = car.isElectric,
                        let fuelType = car.fuelType {
                        return Car(
                            id: id,
                            lat: lat,
                            lon: lon,
                            img: img,
                            model: model,
                            number: number,
                            distance: distance, // Int
                            walktime: walktime,
                            fuel: fuel,
                            tankVolume: tankVolume,
                            seats: seats,
                            remainPath: remainPath,
                            powerReserve: powerReserve,
                            hasTransponder: hasTransponder, // Bool
                            boosterSeat: boosterSeat,
                            babySeat: babySeat,
                            forSale: forSale,
                            engineWarnUpAvailable: engineWarnUpAvailable,
                            isElectric: isElectric,
                            fuelType: fuelType
                        )
                    }
                    return nil
                }
                
                let mapItems = cars?.compactMap { car in
                    let placemark = MKPlacemark(coordinate: car.coordinate)
                    let mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = car.model
                    mapItem.accessibilityHint = car.number
                    mapItem.url = URL(string: car.img)
                    return mapItem
                }
                
                DispatchQueue.main.async {
                    self.cars = mapItems ?? []
                    self.carsIsLoaded = true
                }
            }
        }
    }
    
    func loadBonusBalance() {
        networkManager.getBonusCount { response, error in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.bonusBalance = String(response?.balance ?? 0)
            }
        }
    }
    
}
