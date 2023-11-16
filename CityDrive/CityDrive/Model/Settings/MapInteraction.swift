import Foundation
import _MapKit_SwiftUI

enum MapInteraction: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case pan, zoom, rotate, pitch

    var title: String {
        switch self {
        case .pan: return "Панорамирование"
        case .zoom: return "Масштабирование"
        case .pitch: return "3D"
        case .rotate: return "Вращение"
        }
    }

    var mapValue: MapInteractionModes {
        switch self {
        case .pan: return .pan
        case .zoom: return .zoom
        case .pitch: return .pitch
        case .rotate: return .rotate
        }
    }
}
