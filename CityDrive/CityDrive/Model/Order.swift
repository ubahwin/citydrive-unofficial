//
//  Order.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct Order {
    var amount: String = ""
    
//    var locationStart, locationFinish: Location
    
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
}

struct Location {
    let timestamp, address: String
    let lat, lon: Double
}
