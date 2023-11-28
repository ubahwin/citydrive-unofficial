import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var cars: [Car] = []
    @Published var greenArea: GreenArea? = Settings.greenArea
    @Published var bonusBalance = ""

    @Published var mapIsLoad = false
    @Published var carsIsLoaded = false

    @Published var currentCar: Car?
    @Published var currentCarWalktime: Int?
    @Published var routeToCurCar: MKRoute?
    @Published var currentCarAnnotation: MKAnnotationView?
    @Published var drawRoad = false
    @Published var openCarDetail = false

    @Published var goToUser = false

    // Настройки
    @AppStorage(Settings.city) var city: City?
    @AppStorage(Settings.mapType) var mapType: MapType?

    init() {
        self.networkManager = NetworkManager()
        loadCarsStatus()
        loadGreenArea()
    }

    func loadGreenArea() {
        networkManager.getGreenArea { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            guard let greenAreaResponse: GreenAreaResponse = response else { return }

            let greenArea: GreenArea = greenAreaResponse.mapToGreenArea()

            DispatchQueue.main.async {
                self.greenArea = greenArea
                Settings.greenArea = greenArea
            }
        }
    }

    func loadCarsStatus() {
        guard let currentCity = self.city?.areaGroupID else { return }

        self.carsIsLoaded = false

        networkManager.getCarStatus { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            guard let carsResponse: [CarResponse] = response?.cars else { return }

            var newCars = [Car]()

            for carResponse in carsResponse where carResponse.areaGroupID == currentCity {
                newCars.append(carResponse.mapToCar())
            }

            DispatchQueue.main.async {
                self.cars = newCars
                self.carsIsLoaded = true
                self.mapIsLoad = true
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

    func bookingCar() { }

    func setCurrentCar(id: UUID) {
        self.currentCar = cars.first(where: { $0.id == id })
    }
}
