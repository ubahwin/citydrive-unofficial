import Foundation

struct EventOrder: Identifiable {
    var id: UUID
    var state, name, status, time: String
    var cost: Int
    var duration: Double
    var lat, lon: Double
    var userLat, userLon: Double
}
