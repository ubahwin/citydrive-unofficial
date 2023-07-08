//
//  OrderResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation

struct OrderResponse: Codable {
    let carID, carNumber, carModel: String?
    let carImg: String?
    let carImgSide: String?
    let cityName: String?
    let carOdometer: CarOdometerResponse?
    
    let timezoneOffset: Int?
    
    let events: [EventResponse]?
    
    let achievements: [AchievementResponse]?
    
    let check: CheckResponse?
    
    let transactionInfo: TransactionInfoResponse?
    let isActive: Bool?
    let period: PeriodResponse?
    let path: PathResponse?
    let kasko: Bool?
    let currency: CurrencyResponse?
    let tariffPackage, zoneExpansion: String?
    let tariffMode: String?
    let user: UserResponse?
    let billingTransactionInfo: BillingTransactionInfoResponse?
    let loyaltyProgram: LoyaltyProgramResponse?
    let orderSource: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case carID = "car_id"
        case carNumber = "car_number"
        case carModel = "car_model"
        case carImg = "car_img"
        case carImgSide = "car_img_side"
        case cityName = "city_name"
        case timezoneOffset = "timezone_offset"
        case events, achievements, check
        case transactionInfo = "transaction_info"
        case isActive = "is_active"
        case period, path, kasko, currency
        case carOdometer = "car_odometer"
        case tariffPackage = "tariff_package"
        case zoneExpansion = "zone_expansion"
        case tariffMode = "tariff_mode"
        case user
        case billingTransactionInfo = "billing_transaction_info"
        case loyaltyProgram = "loyalty_program"
        case orderSource = "order_source"
        case success
    }
}

struct AchievementResponse: Codable {
    let achievementID, type, name: String?
    let amount: Int?
    let once: Bool?
    let properties: String?
    let isInsurance: Bool?

    enum CodingKeys: String, CodingKey {
        case achievementID = "achievement_id"
        case type, name, amount, once, properties
        case isInsurance = "is_insurance"
    }
}

struct BillingTransactionInfoResponse: Codable {
    let totalByType: [String]?
}

struct CarOdometerResponse: Codable {
    let atStart, atFinish: Int?

    enum CodingKeys: String, CodingKey {
        case atStart = "at_start"
        case atFinish = "at_finish"
    }
}

struct CheckResponse: Codable {
    let usageTime, usageCost, usagePrice: Int?
    let usagePriceType: String?
    let usageWorkdayTime, usageWorkdayCost, usageWorkdayPrice: Int?
    let usageWorkdayPriceType: String?
    let usageWeekendTime, usageWeekendCost, usageWeekendPrice: Int?
    let usageWeekendPriceType: String?
    let chargingTime, chargingCost, chargingPrice: Int?
    let chargingPriceType: String?
    let parkingTime, parkingCost, parkingPrice: Int?
    let parkingPriceType: String?
    let parkingNightTime, parkingNightCost, parkingNightPrice: Int?
    let parkingNightPriceType: String?
    let transferTime, transferCost, transferPrice: Int?
    let transferPriceType: String?
    let transferNightTime, transferNightCost, transferNightPrice: Int?
    let transferNightPriceType: String?
    let waitingTime, waitingCost, waitingPrice: Int?
    let waitingPriceType: String?
    let fixTariffTime, fixTariffCost, fixTariffPrice: Int?
    let fixTariffPriceType: String?
    let bookingTime, bookingTimeLeft, waitingTimeLeft, finishCost: Int?
    let insuranceIncluded: Bool?
    let currencyID: String?
    let riskProfileLevel, riskProfilePoints, dailyPrice: Int?
    let dailyPriceType: String?
    let dailyCost, dailyTime: Int?
    let dailyStatus: Bool?
    let discountPercent, discountPrice, totalCost, percentDiscountPrice: Int?
    let totalCostWithDiscount: Int?

    enum CodingKeys: String, CodingKey {
        case usageTime = "usage_time"
        case usageCost = "usage_cost"
        case usagePrice = "usage_price"
        case usagePriceType = "usage_price_type"
        case usageWorkdayTime = "usage_workday_time"
        case usageWorkdayCost = "usage_workday_cost"
        case usageWorkdayPrice = "usage_workday_price"
        case usageWorkdayPriceType = "usage_workday_price_type"
        case usageWeekendTime = "usage_weekend_time"
        case usageWeekendCost = "usage_weekend_cost"
        case usageWeekendPrice = "usage_weekend_price"
        case usageWeekendPriceType = "usage_weekend_price_type"
        case chargingTime = "charging_time"
        case chargingCost = "charging_cost"
        case chargingPrice = "charging_price"
        case chargingPriceType = "charging_price_type"
        case parkingTime = "parking_time"
        case parkingCost = "parking_cost"
        case parkingPrice = "parking_price"
        case parkingPriceType = "parking_price_type"
        case parkingNightTime = "parking_night_time"
        case parkingNightCost = "parking_night_cost"
        case parkingNightPrice = "parking_night_price"
        case parkingNightPriceType = "parking_night_price_type"
        case transferTime = "transfer_time"
        case transferCost = "transfer_cost"
        case transferPrice = "transfer_price"
        case transferPriceType = "transfer_price_type"
        case transferNightTime = "transfer_night_time"
        case transferNightCost = "transfer_night_cost"
        case transferNightPrice = "transfer_night_price"
        case transferNightPriceType = "transfer_night_price_type"
        case waitingTime = "waiting_time"
        case waitingCost = "waiting_cost"
        case waitingPrice = "waiting_price"
        case waitingPriceType = "waiting_price_type"
        case fixTariffTime = "fix_tariff_time"
        case fixTariffCost = "fix_tariff_cost"
        case fixTariffPrice = "fix_tariff_price"
        case fixTariffPriceType = "fix_tariff_price_type"
        case bookingTime = "booking_time"
        case bookingTimeLeft = "booking_time_left"
        case waitingTimeLeft = "waiting_time_left"
        case finishCost = "finish_cost"
        case insuranceIncluded = "insurance_included"
        case currencyID = "currency_id"
        case riskProfileLevel = "risk_profile_level"
        case riskProfilePoints = "risk_profile_points"
        case dailyPrice = "daily_price"
        case dailyPriceType = "daily_price_type"
        case dailyCost = "daily_cost"
        case dailyTime = "daily_time"
        case dailyStatus = "daily_status"
        case discountPercent = "discount_percent"
        case discountPrice = "discount_price"
        case totalCost = "total_cost"
        case percentDiscountPrice = "percent_discount_price"
        case totalCostWithDiscount = "total_cost_with_discount"
    }
}

struct CurrencyResponse: Codable {
    let currencyCode, currencySymbol: String?
    let currencyDivider: Int?

    enum CodingKeys: String, CodingKey {
        case currencyCode = "currency_code"
        case currencySymbol = "currency_symbol"
        case currencyDivider = "currency_divider"
    }
}

struct EventResponse: Codable {
    let state, name, status, time: String?
    let lat, lon: Double?
    let isPassive: Bool?
    let cost: Int?
    let duration: Double?
    let userLat, userLon: Double?
    let adminID: String?
    let details: DetailsResponse?

    enum CodingKeys: String, CodingKey {
        case state, name, status, time, lat, lon
        case isPassive = "is_passive"
        case cost, duration
        case userLat = "user_lat"
        case userLon = "user_lon"
        case adminID = "admin_id"
        case details
    }
}

struct DetailsResponse: Codable {
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

struct LoyaltyProgramResponse: Codable {
    let programType, status: String?
    let percent: Int?
}

struct PathResponse: Codable {
    let start, finish: FinishResponse?
}

struct FinishResponse: Codable {
    let lat, lon: Double?
}

struct PeriodResponse: Codable {
    let start, finish: String?
}

struct TransactionInfoResponse: Codable {
    let status: String?
    let transactionInfoData: DataClassResponse?
    let data: String?

    enum CodingKeys: String, CodingKey {
        case status
        case transactionInfoData = "data"
        case data = "_data"
    }
}

struct DataClassResponse: Codable {
    let product: ProductResponse?
    let isCreated: Bool?
    let dataPaymentResponses, paymentResponses: String?

    enum CodingKeys: String, CodingKey {
        case product, isCreated
        case dataPaymentResponses = "paymentResponses"
        case paymentResponses = "_paymentResponses"
    }
}

struct ProductResponse: Codable {
    let productID, name, userID: String?
    let isDone: Bool?
    let idempotencyKey: String?
    let createdAt, updatedAt: AtedAtResponse?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case name
        case userID = "userId"
        case isDone, idempotencyKey, createdAt, updatedAt
    }
}

struct AtedAtResponse: Codable {
    let seconds: String?
    let nanos: Int?
}

struct UserResponse: Codable {
    let userID, firstName, lastName, fullName: String?
    let middleName, email: String?
    let phone: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case middleName = "middle_name"
        case email, phone
    }
}

extension CheckResponse {
    var totalCostString: String {
        return String(format: "%.2f", totalCostDouble).replacingOccurrences(of: ".", with: ",")
    }
    
    var totalCostDouble: Double {
        return Double(totalCost ?? 0) / 100.0
    }
}
