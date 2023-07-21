//
//  City.swift
//  CityDrive
//
//  Created by Иван Вдовин on 19.07.2023.
//

import Foundation
import MapKit

enum City: String, CaseIterable, Identifiable {
    case Moscow, SPb, Sochi

    var id: Self { self }
    
    var areaGroupID: String {
        switch self {
        case .Moscow: return "moscow"
        case .Sochi: return "sochi"
        case .SPb: return "saint_petersburg"
        }
    }
    
    var title: String {
        switch self {
        case .Moscow: return "Москва"
        case .Sochi: return "Сочи"
        case .SPb: return "Санкт-Петербург"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .Moscow: return CLLocationCoordinate2D(latitude: 55.75222, longitude: 37.61556)
        case .Sochi: return CLLocationCoordinate2D(latitude: 59.93863, longitude: 30.31413)
        case .SPb: return CLLocationCoordinate2D(latitude: 43.59917, longitude: 39.72569)
        }
    }
}
