import XCTest
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
}
