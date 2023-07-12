//
//  StringConvertor.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import Foundation

class StringConverter {
    static func ISO8601ToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: string)!
    }
}
