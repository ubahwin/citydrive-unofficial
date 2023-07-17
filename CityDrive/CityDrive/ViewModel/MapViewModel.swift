//
//  MapViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var cars: [Car] = []
    
    private var networkManager: NetworkManager
        
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
                let cars = response?.cars?.compactMap { car in
                    if
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
                
                if let cars = cars {
                    DispatchQueue.main.async {
                        self.cars = cars
                    }
                }
            }
        }
    }
}
