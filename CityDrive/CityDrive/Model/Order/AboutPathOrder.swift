import Foundation

struct PathOrder {
    var start, finish: LocateOrder
    var period: PeriodOrder
}

struct LocateOrder {
    var lat, lon: Double
}

struct PeriodOrder {
    var start, finish: String
}
