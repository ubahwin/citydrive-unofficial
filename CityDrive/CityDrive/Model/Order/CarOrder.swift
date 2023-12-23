import Foundation

struct CarOrder {
    var id, number, model, img: String
    var odometer: Odometer
}

struct Odometer {
    var atStart, atFinish: Int
}
