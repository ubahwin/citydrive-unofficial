import Foundation
import _MapKit_SwiftUI

enum MapType: String, CaseIterable, Identifiable {
    case hybrid, standard
    var id: Self { self }

    /// Для Map из SwiftUI
    var mapStyle: MapStyle {
        switch self {
        case .hybrid: return .hybrid
        case .standard: return .standard
        }
    }

    /// Для императивной MKMapView
    var mapType: MKMapType {
        switch self {
        case .hybrid: return .hybrid
        case .standard: return .standard
        }
    }

    var title: String {
        switch self {
        case .hybrid: return "Гибрид"
        case .standard: return "Стандартная"
        }
    }
}
