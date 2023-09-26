import Foundation
import MapKit

enum City: String, CaseIterable, Identifiable {
    case moscow, spb, sochi

    var id: Self { self }

    var areaGroupID: String {
        switch self {
        case .moscow: return "moscow"
        case .sochi: return "sochi"
        case .spb: return "saint_petersburg"
        }
    }

    var title: String {
        switch self {
        case .moscow: return "Москва"
        case .sochi: return "Сочи"
        case .spb: return "Санкт-Петербург"
        }
    }

    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .moscow: return CLLocationCoordinate2D(latitude: 55.75222, longitude: 37.61556)
        case .sochi: return CLLocationCoordinate2D(latitude: 59.93863, longitude: 30.31413)
        case .spb: return CLLocationCoordinate2D(latitude: 43.59917, longitude: 39.72569)
        }
    }
}
