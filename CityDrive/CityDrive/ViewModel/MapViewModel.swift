import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var carsIsLoaded = false
    @Published var cars: [MKMapItem] = []
    @Published var bonusBalance = ""

    // Настройки
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
                print(error) // TODO: logging
                return
            }

            if let carsResponse: [CarResponse] = response?.cars {
                var cars = [Car]()

                for carResponse in carsResponse where carResponse.areaGroupID == self.city?.areaGroupID {
                    let car = carResponse.mapToCars()
                    cars.append(car)
                }

                let mapItems = cars.compactMap { car in
                    let placemark = MKPlacemark(coordinate: car.coordinate)
                    let mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = car.model
                    mapItem.accessibilityHint = car.number
                    mapItem.url = URL(string: car.img)
                    return mapItem
                }

                DispatchQueue.main.async {
                    self.cars = mapItems
                    self.carsIsLoaded = true
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
