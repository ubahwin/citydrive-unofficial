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
    @Published var cars: [Car] = []
    @Published var bonusBalance = ""
    
    //==========================
    //
    // TODO: change in settings
    //
    @AppStorage("selectedCity") var city: City?
    @AppStorage("selectedMapType") var mapType: MapType?
    var interactions: MapInteractionModes = [.pan, .zoom]
    //
    //==========================

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
                        let distance = car.distance {
                        return Car(
                            id: id,
                            lat: lat,
                            lon: lon,
                            img: img,
                            model: model,
                            number: number,
                            distance: distance,
                            walktime: 0,
                            fuel: 0,
                            tankVolume: 0,
                            powerReserve: 0,
                            tankVolumeEmergency: 0,
                            discount: 0,
                            transferable: false,
                            seats: 0,
                            remainPath: 0,
                            carFilterID: "",
                            notAvailable: false,
                            horn: false,
                            isElectric: false,
                            tariffID: "",
                            chargingLevel: 0,
                            remainPathElectric: 0,
                            areaGroupID: "",
                            engineWarnUpAvailable: false,
                            carFilterCompany: CarFilterCompany(),
                            transferringIsAvailable: false,
                            boosterSeat: false,
                            babySeat: false,
                            forSale: false,
                            eOsagoLink: "",
                            wrapBrand: "",
                            fuelType: "",
                            inTransfer: false,
                            hasTransponder: false,
                            transferModeExists: false,
                            engineWarnUp: false,
                            wrapBrandLogo: ""
                        )
                    }
                    return nil
                }
                
//                let mapItems = cars?.compactMap { car in
//                    let placemark = MKPlacemark(coordinate: car.coordinate)
//                    let mapItem = MKMapItem(placemark: placemark)
//                    mapItem.name = car.model
//                    return mapItem
//                }
                
                DispatchQueue.main.async {
                    self.cars = cars ?? []
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
