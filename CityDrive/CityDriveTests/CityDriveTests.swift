import XCTest
import MapKit
@testable import CityDrive

final class CityDriveTests: XCTestCase {
    let cars: [Car] = [
        Car(
            id: UUID(),
            location: Point(latitude: 121, longitude: 211),
            img: URL(fileURLWithPath: ""),
            model: "kia ria",
            number: CarNumber(number: "a111aa777"),
            transferable: true,
            powerReserveMeters: 1,
            seats: 2,
            remainPath: 1,
            hasTransponder: true,
            boosterSeat: true,
            babySeat: true,
            forSale: true,
            engineWarnUpAvailable: true,
            isElectric: true,
            fuelType: "92"
        ),
        Car(
            id: UUID(),
            location: Point(latitude: 142, longitude: 211),
            img: URL(fileURLWithPath: ""),
            model: "asdasf",
            number: CarNumber(number: "adf"),
            transferable: false,
            powerReserveMeters: 1,
            seats: 5,
            remainPath: 1,
            hasTransponder: false,
            boosterSeat: false,
            babySeat: false,
            forSale: false,
            engineWarnUpAvailable: false,
            isElectric: false,
            fuelType: "92"
        ),
        Car(
            id: UUID(),
            location: Point(latitude: 122, longitude: 21),
            img: URL(fileURLWithPath: ""),
            model: "nissa",
            number: CarNumber(number: "a111aa777"),
            transferable: true,
            powerReserveMeters: 1,
            seats: 2,
            remainPath: 1,
            hasTransponder: true,
            boosterSeat: true,
            babySeat: true,
            forSale: true,
            engineWarnUpAvailable: true,
            isElectric: true,
            fuelType: "92"
        )
    ]

    func test_MapViewModel_setCurrentCar() {
        let mapVM = MapViewModel()

        mapVM.cars = cars

        mapVM.setCurrentCar(id: cars.first!.id)

        XCTAssert(mapVM.currentCar == cars.first)
    }

    func test_City_nearestCitySpb() {
        let myLocation = CLLocation(latitude: 59.894210, longitude: 30.297850)

        XCTAssert(City.nearestCity(with: myLocation) == .spb)
    }

    func test_City_nearestCityMoscow() {
        let myLocation = CLLocation(latitude: 56.028283, longitude: 39.485681)

        XCTAssert(City.nearestCity(with: myLocation) == .moscow)
    }
}
