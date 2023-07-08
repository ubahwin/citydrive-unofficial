//
//  ShortOrder.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct ShortOrder: Identifiable {
    var id: UUID
    var startedAt: String
    var amount: String
}

extension ShortOrder {
    var idString: String {
        return id.uuidString
    }
    
    var amountAsDouble: Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .decimal
        let cleanedString = amount.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if let doubleValue = formatter.number(from: cleanedString)?.doubleValue {
            return doubleValue
        } else {
            return 0
        }
    }
    
    var startedAtToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: startedAt)!
    }
}
