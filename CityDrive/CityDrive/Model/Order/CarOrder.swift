import Foundation

struct CarOrder {
    var id, model, img: String
    var number: CarNumber
    var odometer: Odometer
}

struct Odometer {
    var atStart, atFinish: Int
}
