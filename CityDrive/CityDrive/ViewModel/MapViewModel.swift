import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var cars: [Car] = []

    @Published var mapIsUpdate = false
    @Published var carsIsLoaded = false
    @Published var bonusBalance = ""

    // Настройки
    @AppStorage(Settings.city) var city: City?
    @AppStorage(Settings.mapType) var mapType: MapType?

    init() {
        self.networkManager = NetworkManager()
        loadCarsStatus()
    }

    func loadCarsStatus() {
        networkManager.getCarStatus { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let carsResponse: [CarResponse] = response?.cars {
                var cars = [Car]()

                for carResponse in carsResponse where carResponse.areaGroupID == self.city?.areaGroupID {
                    let car = carResponse.mapToCars()
                    cars.append(car)
                }
                DispatchQueue.main.async {
                    self.cars = cars
                    self.carsIsLoaded = true
                    self.mapIsUpdate = false
                }
            }
        }
    }

    func loadBonusBalance() {
        networkManager.getBonusCount { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            DispatchQueue.main.async {
                self.bonusBalance = String(response?.balance ?? 0)
            }
        }
    }
}
