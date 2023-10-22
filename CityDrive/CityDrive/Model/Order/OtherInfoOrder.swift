import Foundation

struct OtherInfoOrder {
    var currency: Currency
    var kasko: Bool
    var orderSource: String
    var loyaltyProgram: LoyaltyProgram
    var timezoneOffset: Int
    var achievements: [AchievementOrder]
    var transactionInfo: TransactionInfo
    var cityName: String
    var tariffPackage, zoneExpansion, tariffMode: String
    var success: Bool
    var isActive: Bool

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

    var riskProfileLevel, riskProfilePoints: Int

    var dailyPriceType: String
    var dailyCost, dailyTime, dailyPrice: Int
    var dailyStatus: Bool

    var discountPercent, discountPrice, percentDiscountPrice: Int
    var totalCost: String
    var totalCostWithDiscount: Int
}

struct LoyaltyProgram {
    var programType, status: String
    var percent: Int
}

struct Currency {
    var code, symbol: String
}

struct AchievementOrder: Identifiable {
    var id: UUID
    var type, name: String
    var amount: Int
    var once: Bool
    var properties: AchievementPropertyOrder
    var isInsurance: Bool
}

struct AchievementPropertyOrder {
    var urentComboTariffID: String
    var currency: Int
}

struct TransactionInfo {
    var status: String
    var isCreated: Bool
    var data: String
}
