//
//  ShortOrder.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct ShortOrder: Identifiable {
    var id: UUID
    var startedAt: Date
    var amount: String
}
