import Foundation
import MapKit

struct Point: Codable {
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
