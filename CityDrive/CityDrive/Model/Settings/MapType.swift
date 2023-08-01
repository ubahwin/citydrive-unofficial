//
//  MapType.swift
//  CityDrive
//
//  Created by Иван Вдовин on 22.07.2023.
//

import Foundation
import _MapKit_SwiftUI

enum MapType: String, CaseIterable, Identifiable {
    case hybrid, standard
    var id: Self { self }
    
    var mapStyle: MapStyle {
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
