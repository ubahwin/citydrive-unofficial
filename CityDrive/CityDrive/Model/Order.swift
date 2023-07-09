//
//  Order.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct Order {
    var car: CarOrder
    var cityName: String
    
    var events: [EventOrder]
    var check: CheckOrder
    
    var isActive: Bool
    
    var period: Period
    var path: Path
    
    var kasko: Bool
    
    var currency: Currency
    
    var user: UserOrder
    
    var loyaltyProgram: LoyaltyProgram
    
    var orderSource: String
    var success: Bool
    
    var nn: NNOrder
    
    
    
    var totalCostAsDouble: Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .decimal
        let cleanedString = check.totalCost.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if let doubleValue = formatter.number(from: cleanedString)?.doubleValue {
            return doubleValue
        } else {
            return 0
        }
    }
}

struct LoyaltyProgram {
    var programType, status: String
    var percent: Int
}

struct UserOrder {
    var userID, firstName, lastName, fullName: String
    var middleName, email: String
    var phone: Int
}

struct Currency {
    var code, symbol: String
}

struct Path {
    var start, finish: Finish
}

struct Finish {
    var lat, lon: Double
}

struct Period {
    var start, finish: String
}

struct CheckOrder {
    var usageTime, usageCost, usagePrice: Int
    var usagePriceType: String
    var usageWorkdayTime, usageWorkdayCost, usageWorkdayPrice: Int
    var usageWorkdayPriceType: String
    var usageWeekendTime, usageWeekendCost, usageWeekendPrice: Int
    var usageWeekendPriceType: String
    var chargingTime, chargingCost, chargingPrice: Int
    var chargingPriceType: String
    var parkingTime, parkingCost, parkingPrice: Int
    var parkingPriceType: String
    var parkingNightTime, parkingNightCost, parkingNightPrice: Int
    var parkingNightPriceType: String
    var transferTime, transferCost, transferPrice: Int
    var transferPriceType: String
    var transferNightTime, transferNightCost, transferNightPrice: Int
    var transferNightPriceType: String
    var waitingTime, waitingCost, waitingPrice: Int
    var waitingPriceType: String
    var fixTariffTime, fixTariffCost, fixTariffPrice: Int
    var fixTariffPriceType: String
    var bookingTime, bookingTimeLeft, waitingTimeLeft, finishCost: Int
    var insuranceIncluded: Bool
    var riskProfileLevel, riskProfilePoints, dailyPrice: Int
    var dailyPriceType: String
    var dailyCost, dailyTime: Int
    var dailyStatus: Bool
    var discountPercent, discountPrice, percentDiscountPrice: Int
    var totalCost: String
    var totalCostWithDiscount: Int
}

struct EventOrder {
    var state, name, status, time: String
    var lat, lon: Double
    var isPassive: Bool
    var cost: Int
    var duration: Double
    var userLat, userLon: Double
}

struct NNOrder {
    var timezoneOffset: Int
    var achievements: [AchievementOrder]
    var transactionInfo: TransactionInfo
    
    var tariffPackage, zoneExpansion, tariffMode: String
}

struct TransactionInfo {
    var status: String
    var isCreated: Bool
    var data: String
    var dataPaymentResponses, paymentResponses: String
}

struct AchievementOrder {
    var type, name: String
    var amount: Int
    var once: Bool
    var properties: String
    var isInsurance: Bool
}

struct CarOrder {
    var id, number, model, img, side: String
    var odometer: Odometer
}

struct Odometer {
    var atStart, atFinish: Int
}
