import Foundation
import MapKit

struct Car: Identifiable {
    var id: UUID

    var lat: Double
    var lon: Double
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    var img: String
    var model: String
    var number: String

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
        let img = self.img ?? ""
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

        return Car(
            id: id,
            lat: lat,
            lon: lon,
            img: img,
            model: model,
            number: number,
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
