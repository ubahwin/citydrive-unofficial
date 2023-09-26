import SwiftUI

struct OtherInfoView: View {
    var otherInfo: OtherInfoOrder?

    var body: some View {
        List {
            Section {
                SimpleCellView(name: "Город", value: otherInfo?.cityName)
                SimpleCellView(name: "Есть ли каско", value: otherInfo?.kasko)
            }
            Section {
                SimpleCellView(name: "isActive", value: otherInfo?.isActive)
                SimpleCellView(name: "orderSource", value: otherInfo?.orderSource)
                SimpleCellView(name: "tariffMode", value: otherInfo?.tariffMode)
                SimpleCellView(name: "tariffPackage", value: otherInfo?.tariffPackage)
                SimpleCellView(name: "zoneExpansion", value: otherInfo?.zoneExpansion)
            }

            Section("Достижения") {
                ForEach(otherInfo?.achievements ?? []) { achievement in
                    VStack {
                        SimpleCellView(name: "type", value: achievement.type)
                        SimpleCellView(name: "name", value: achievement.name)
                        SimpleCellView(name: "amount", value: achievement.amount)
                        SimpleCellView(name: "once", value: achievement.once)
                        SimpleCellView(name: "properties", value: achievement.properties)
                        SimpleCellView(name: "isInsurance", value: achievement.isInsurance)
                    }
                }
            }

            Section {
                VStack {
                    SimpleCellView(name: "usageTime", value: otherInfo?.usageTime)
                    SimpleCellView(name: "usageCost", value: otherInfo?.usageCost)
                    SimpleCellView(name: "usagePrice", value: otherInfo?.usagePrice)
                    SimpleCellView(name: "usagePriceType", value: otherInfo?.usagePriceType)
                }
                VStack {
                    SimpleCellView(name: "usageWorkdayTime", value: otherInfo?.usageWorkdayTime)
                    SimpleCellView(name: "usageWorkdayCost", value: otherInfo?.usageWorkdayCost)
                    SimpleCellView(name: "usageWorkdayPrice", value: otherInfo?.usageWorkdayPrice)
                    SimpleCellView(name: "usageWorkdayPriceType", value: otherInfo?.usageWorkdayPriceType)
                }
                VStack {
                    SimpleCellView(name: "usageWeekendTime", value: otherInfo?.usageWeekendTime)
                    SimpleCellView(name: "usageWeekendCost", value: otherInfo?.usageWeekendCost)
                    SimpleCellView(name: "usageWeekendPrice", value: otherInfo?.usageWeekendPrice)
                    SimpleCellView(name: "usageWeekendPriceType", value: otherInfo?.usageWeekendPriceType)
                }
                VStack {
                    SimpleCellView(name: "chargingTime", value: otherInfo?.chargingTime)
                    SimpleCellView(name: "chargingCost", value: otherInfo?.chargingCost)
                    SimpleCellView(name: "chargingPrice", value: otherInfo?.chargingPrice)
                    SimpleCellView(name: "chargingPriceType", value: otherInfo?.chargingPriceType)
                }
                VStack {
                    SimpleCellView(name: "parkingTime", value: otherInfo?.parkingTime)
                    SimpleCellView(name: "parkingCost", value: otherInfo?.parkingCost)
                    SimpleCellView(name: "parkingPrice", value: otherInfo?.parkingPrice)
                    SimpleCellView(name: "parkingPriceType", value: otherInfo?.parkingPriceType)
                }
                VStack {
                    SimpleCellView(name: "parkingNightTime", value: otherInfo?.parkingNightTime)
                    SimpleCellView(name: "parkingNightCost", value: otherInfo?.parkingNightCost)
                    SimpleCellView(name: "parkingNightPrice", value: otherInfo?.parkingNightPrice)
                    SimpleCellView(name: "parkingNightPriceType", value: otherInfo?.parkingNightPriceType)
                }
                VStack {
                    SimpleCellView(name: "transferTime", value: otherInfo?.transferTime)
                    SimpleCellView(name: "transferCost", value: otherInfo?.transferCost)
                    SimpleCellView(name: "transferPrice", value: otherInfo?.transferPrice)
                    SimpleCellView(name: "transferPriceType", value: otherInfo?.transferPriceType)
                }
                VStack {
                    SimpleCellView(name: "transferNightTime", value: otherInfo?.transferNightTime)
                    SimpleCellView(name: "transferNightCost", value: otherInfo?.transferNightCost)
                    SimpleCellView(name: "transferNightPrice", value: otherInfo?.transferNightPrice)
                    SimpleCellView(name: "transferNightPriceType", value: otherInfo?.transferNightPriceType)
                }
                VStack {
                    SimpleCellView(name: "waitingTime", value: otherInfo?.waitingTime)
                    SimpleCellView(name: "waitingCost", value: otherInfo?.waitingCost)
                    SimpleCellView(name: "waitingPrice", value: otherInfo?.waitingPrice)
                    SimpleCellView(name: "waitingPriceType", value: otherInfo?.waitingPriceType)
                }
                VStack {
                    SimpleCellView(name: "fixTariffTime", value: otherInfo?.fixTariffTime)
                    SimpleCellView(name: "fixTariffCost", value: otherInfo?.fixTariffCost)
                    SimpleCellView(name: "fixTariffPrice", value: otherInfo?.fixTariffPrice)
                    SimpleCellView(name: "fixTariffPriceType", value: otherInfo?.fixTariffPriceType)
                }
                VStack {
                    SimpleCellView(name: "bookingTime", value: otherInfo?.bookingTime)
                    SimpleCellView(name: "bookingTimeLeft", value: otherInfo?.bookingTimeLeft)
                    SimpleCellView(name: "waitingTimeLeft", value: otherInfo?.waitingTimeLeft)
                    SimpleCellView(name: "finishCost", value: otherInfo?.finishCost)
                    SimpleCellView(name: "insuranceIncluded", value: otherInfo?.insuranceIncluded)
                }
                VStack {
                    SimpleCellView(name: "dailyPriceType", value: otherInfo?.dailyPriceType)
                    SimpleCellView(name: "dailyCost", value: otherInfo?.dailyCost)
                    SimpleCellView(name: "dailyTime", value: otherInfo?.dailyTime)
                    SimpleCellView(name: "dailyPrice", value: otherInfo?.dailyPrice)
                    SimpleCellView(name: "dailyStatus", value: otherInfo?.dailyStatus)
                }
            }

            Section {
                SimpleCellView(name: "discountPercent", value: otherInfo?.discountPercent)
                SimpleCellView(name: "discountPrice", value: otherInfo?.discountPrice)
                SimpleCellView(name: "percentDiscountPrice", value: otherInfo?.percentDiscountPrice)
                SimpleCellView(name: "totalCost", value: otherInfo?.totalCost)
                SimpleCellView(name: "totalCostWithDiscount", value: otherInfo?.totalCostWithDiscount)
            }

            Section {
                SimpleCellView(name: "riskProfileLevel", value: otherInfo?.riskProfileLevel)
                SimpleCellView(name: "riskProfilePoints", value: otherInfo?.riskProfilePoints)
            }

            Section("Валюта") {
                SimpleCellView(name: "Код", value: otherInfo?.currency.code)
                SimpleCellView(name: "Символ", value: otherInfo?.currency.symbol)
            }

            Section("Транзакция") {
                SimpleCellView(name: "status", value: otherInfo?.transactionInfo.status)
                SimpleCellView(name: "isCreated", value: otherInfo?.transactionInfo.isCreated)
                SimpleCellView(name: "data", value: otherInfo?.transactionInfo.data)
            }

            Section("Программа лояльности") {
                SimpleCellView(name: "programType", value: otherInfo?.loyaltyProgram.programType)
                SimpleCellView(name: "status", value: otherInfo?.loyaltyProgram.status)
                SimpleCellView(name: "percent", value: otherInfo?.loyaltyProgram.percent)
            }
        }
    }
}

#Preview {
    OtherInfoView()
}
