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
