import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var cars: [Car] = []
    @Published var greenArea: GreenArea? = Settings.greenArea
    @Published var bonusBalance = ""

    @Published var mapIsUpdate = false
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
        networkManager.getCarStatus { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            guard let carsResponse: [CarResponse] = response?.cars else { return }

            var cars = [Car]()
            let curCity = self.city?.areaGroupID

            for carResponse in carsResponse where carResponse.areaGroupID == curCity {
                let car = carResponse.mapToCar()
                cars.append(car)
            }

            DispatchQueue.main.async {
                self.cars = cars
                self.carsIsLoaded = true
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

    func drawRoadToCurrentCar() {
        drawRoad.toggle()
    }

    func setCurrentCar(id: UUID) {
        self.currentCar = cars.first(where: { $0.id == id })
    }
}
