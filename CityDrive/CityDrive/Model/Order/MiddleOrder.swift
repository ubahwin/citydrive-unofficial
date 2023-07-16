//
//  MiddleOrder.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.07.2023.
//

import Foundation

struct MiddleOrder {
    var locationStart, locationFinish: Location
    var details: MiddleDetails
}

struct MiddleDetails {
    var title, description: String
    var rows: [Row]
}

struct Row: Identifiable {
    var id: UUID
    var rowLeft, rowRight: Column
}

struct Column {
    var text: String
    var iconURL: String
    var color, fontStyle: String
}

struct Location {
    var timestamp, address: String
    var lat, lon: Double
}
