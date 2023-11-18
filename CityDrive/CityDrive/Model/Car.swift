import Foundation
import MapKit

struct Car: Identifiable {
    var id: UUID

    var location: Point

    var img: URL
    var model: String
    var number: String

    var transferable: Bool
    var distance, walktime, fuel, tankVolume, seats, remainPath, powerReserve: Int
    var hasTransponder, boosterSeat, babySeat, forSale, engineWarnUpAvailable, isElectric: Bool
    var fuelType: String
}

extension CarResponse {
    func mapToCar() -> Car {
        let carID = self.carID ?? ""
        let id = UUID(uuidString: carID) ?? UUID()
        let lat = self.lat ?? 0
        let lon = self.lon ?? 0
        let img = URL(string: self.img ?? "")!
        let model = self.model ?? ""
        let number = self.number ?? ""
        let distance = self.distance ?? 0
        let walktime = self.walktime ?? 0
        let fuel = self.fuel ?? 0
        let tankVolume = self.tankVolume ?? 0
        let powerReserve = self.powerReserve ?? 0
        let seats = self.seats ?? 0
        let remainPath = self.remainPath ?? 0
        let hasTransponder = self.hasTransponder ?? false
        let boosterSeat = self.boosterSeat ?? false
        let babySeat = self.babySeat ?? false
        let forSale = self.forSale ?? false
        let engineWarnUpAvailable = self.engineWarnUpAvailable ?? false
        let isElectric = self.isElectric ?? false
        let fuelType = self.fuelType ?? ""
        let transferable = self.transferable ?? false

        return Car(
            id: id,
            location: Point(latitude: lat, longitude: lon),
            img: img,
            model: model,
            number: number,
            transferable: transferable,
            distance: distance,
            walktime: walktime,
            fuel: fuel,
            tankVolume: tankVolume,
            seats: seats,
            remainPath: remainPath,
            powerReserve: powerReserve,
            hasTransponder: hasTransponder,
            boosterSeat: boosterSeat,
            babySeat: babySeat,
            forSale: forSale,
            engineWarnUpAvailable: engineWarnUpAvailable,
            isElectric: isElectric,
            fuelType: fuelType
        )
    }
}
