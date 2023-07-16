//
//  Double.swift
//  CityDrive
//
//  Created by Иван Вдовин on 14.07.2023.
//

import Foundation

extension Double {
    func costToString() -> String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".", with: ",") + " ₽"
    }
    
    func roundedToTwoDecimalPlaces() -> Double {
        let multiplier = pow(10.0, 2.0)
        return (self * multiplier).rounded() / multiplier
    }
}
