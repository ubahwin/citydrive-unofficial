//
//  StringConvertor.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import Foundation

class StringConverter {
    // input string ISO8601 like "2023-07-06T09:01:25.574Z"
    static func ISO8601ToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: string)!
    }
    
    // input string like "6789" where equals for example 67,89 RUB
    static func CostStringToDouble(_ string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .decimal
        let cleanedString = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if let doubleValue = formatter.number(from: cleanedString)?.doubleValue {
            return doubleValue
        } else {
            return 0
        }
    }
}
