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
        
    init() {
        // for test
        let cars = [
            Car(id: UUID(), name: "reno", coordinate: CLLocationCoordinate2D(latitude: 59.901153, longitude: 30.274750)),
            Car(id: UUID(), name: "nissan", coordinate: CLLocationCoordinate2D(latitude: 59.902153, longitude: 30.214750)),
            Car(id: UUID(), name: "motiz", coordinate: CLLocationCoordinate2D(latitude: 59.904153, longitude: 30.294750))
        ]
        self.cars = cars
    }
    
<<<<<<< Updated upstream
    func goToMyLocation() {
        
=======
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
                    mapItem.url = URL(string: car.img)
                    mapItem.accessibilityHint = car.number
                    return mapItem
                }
                
                DispatchQueue.main.async {
                    self.cars = mapItems ?? []
                    self.carsIsLoaded = true
                }
            }
        }
>>>>>>> Stashed changes
    }
}
