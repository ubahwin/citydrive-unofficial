import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var cars: [UUID: Car] = [:]
    @Published var greenArea: GreenArea? = Settings.greenArea
    @Published var bonusBalance = ""

    @Published var mapIsLoad = false
    @Published var carsIsLoaded = false

    @Published var currentCar: Car?
    @Published var currentCarTariff: Tariff?
    @Published var currentCarWalktime: Int?
    @Published var routeToCurCar: MKRoute?
    @Published var currentCarAnnotation: MKAnnotationView?
    @Published var drawRoad = false
    @Published var openCarDetail = false

    @Published var goToUser = false

    // Настройки
    @AppStorage(Settings.city) var city: City = .moscow
    @AppStorage(Settings.mapType) var mapType: MapType = .standard

    init() {
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
        let currentCity = self.city.areaGroupID

        self.carsIsLoaded = false

        networkManager.getCarStatus { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }
            guard let carsDict = response?.cars else { return }

            var carsByArea = [UUID: Car]()
            for (id, carResponse) in carsDict where carResponse.areaGroupID == currentCity {
                carsByArea[id] = carResponse.mapToCar()
            }

            DispatchQueue.main.async {
                self.cars = carsByArea
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

    func loadCarTariff(for carID: UUID) {
        networkManager.getCarTariff(id: carID.uuidString) { response, error in
            if let error = error {
                print(error)
                return
            }

            guard let tariff = response?.tariff else { return }

            let currentCarTariff = tariff.mapToTariff

            DispatchQueue.main.async {
                self.currentCarTariff = currentCarTariff
            }
        }
    }

    func setCurrentCar(id: UUID) {
        self.currentCar = cars[id]
        loadCarTariff(for: id)
    }
}
