import Foundation

struct LargeOrder {
    /// Стоимость за использование
    var usageCost: Double
    /// Итого
    var totalCost: Double
    var parkingCost: Double

    /// Число списанных бонусов
    var bonusCancellationAmount: Double?
    /// Число начисленных бонусов
    var bonusAccrualAmount: Double?

    var car: CarOrder
    var events: [EventOrder]
    var path: PathOrder
    var user: UserOrder
    var otherInfo: OtherInfoOrder
}

extension LargeOrderResponse {
    // swiftlint:disable function_body_length
    func mapToOrder() -> LargeOrder {
        let events = self.events?.compactMap { event in
            let lat = event.lat
            let lon = event.lon
            let userLat = event.userLat
            let userLon = event.userLon
            if
                let state = event.state,
                let name = event.name,
                let status = event.status,
                let time = event.time,
                let cost = event.cost,
                let duration = event.duration {
                return EventOrder(
                    id: UUID(),
                    state: state,
                    name: name,
                    status: status,
                    time: time,
                    cost: cost,
                    duration: duration,
                    lat: lat ?? 0,
                    lon: lon ?? 0,
                    userLat: userLat ?? 0,
                    userLon: userLon ?? 0)
            }
            return nil
        }

        let achievements = self.achievements?.compactMap { achievement in
            let properties = AchievementPropertyOrder(
                urentComboTariffID: achievement.properties?.urentComboTariffID ?? "",
                currency: achievement.properties?.currency ?? 0
            )
            let isInsurance = achievement.isInsurance
            if
                let type = achievement.type,
                let name = achievement.name,
                let amount = achievement.amount,
                let once = achievement.once {
                return AchievementOrder(id: UUID(),
                                        type: type,
                                        name: name,
                                        amount: amount,
                                        once: once,
                                        properties: properties,
                                        isInsurance: isInsurance ?? false)
            }
            return nil
        }

        let order = LargeOrder(
            usageCost: self.check?.usageCost?.costToDouble() ?? 0,
            totalCost: self.check?.totalCostWithDiscount?.costToDouble() ?? 0,
            parkingCost: self.check?.parkingCost?.costToDouble() ?? 0,
            bonusCancellationAmount: 0,
            bonusAccrualAmount: 0,
            car: CarOrder(
                id: self.carID ?? "",
                number: self.carNumber ?? "",
                model: self.carModel ?? "",
                img: self.carImg ?? "",
                odometer: Odometer(
                    atStart: self.carOdometer?.atStart ?? 0,
                    atFinish: self.carOdometer?.atFinish ?? 0)
            ),
            events: events ?? [],
            path: PathOrder(
                start: LocateOrder(
                    lat: self.path?.start?.lat ?? 0,
                    lon: self.path?.start?.lon ?? 0),
                finish: LocateOrder(
                    lat: self.path?.finish?.lat ?? 0,
                    lon: self.path?.finish?.lon ?? 0),
                period: PeriodOrder(
                    start: self.period?.start ?? "",
                    finish: self.period?.finish ?? "")
            ),
            user: UserOrder(userID: self.user?.userID ?? "",
                            firstName: self.user?.firstName ?? "",
                            lastName: self.user?.lastName ?? "",
                            fullName: self.user?.fullName ?? "",
                            middleName: self.user?.middleName ?? "",
                            email: self.user?.email ?? "",
                            phone: self.user?.phone ?? 0),
            otherInfo: OtherInfoOrder(
                currency: Currency(
                    code: self.currency?.currencyCode ?? "",
                    symbol: self.currency?.currencySymbol ?? ""
                ),
                kasko: self.kasko ?? false,
                orderSource: self.orderSource ?? "",
                loyaltyProgram: LoyaltyProgram(
                    programType: self.loyaltyProgram?.programType ?? "",
                    status: self.loyaltyProgram?.status ?? "",
                    percent: self.loyaltyProgram?.percent ?? 0
                ),
                timezoneOffset: self.timezoneOffset ?? 0,
                achievements: achievements ?? [],
                transactionInfo: TransactionInfo(
                    status: self.transactionInfo?.status ?? "",
                    isCreated: self.transactionInfo?.transactionInfoData?.isCreated ?? false,
                    data: self.transactionInfo?.data ?? ""
                ),
                cityName: self.cityName ?? "",
                tariffPackage: self.tariffPackage ?? "",
                zoneExpansion: self.zoneExpansion ?? "",
                tariffMode: self.tariffMode ?? "",
                success: self.success ?? false,
                isActive: self.isActive ?? false,
                usageTime: self.check?.usageTime ?? 0,
                usageCost: self.check?.usageCost ?? 0,
                usagePrice: self.check?.usagePrice ?? 0,
                usagePriceType: self.check?.usagePriceType ?? "",
                usageWorkdayTime: self.check?.usageWorkdayTime ?? 0,
                usageWorkdayCost: self.check?.usageWorkdayCost ?? 0,
                usageWorkdayPrice: self.check?.usageWorkdayPrice ?? 0,
                usageWorkdayPriceType: self.check?.usageWorkdayPriceType ?? "",
                usageWeekendTime: self.check?.usageWeekendTime ?? 0,
                usageWeekendCost: self.check?.usageWeekendCost ?? 0,
                usageWeekendPrice: self.check?.usageWeekendPrice ?? 0,
                usageWeekendPriceType: self.check?.usageWeekendPriceType ?? "",
                chargingTime: self.check?.chargingTime ?? 0,
                chargingCost: self.check?.chargingCost ?? 0,
                chargingPrice: self.check?.chargingPrice ?? 0,
                chargingPriceType: self.check?.chargingPriceType ?? "",
                parkingTime: self.check?.parkingTime ?? 0,
                parkingCost: self.check?.parkingCost ?? 0,
                parkingPrice: self.check?.parkingPrice ?? 0,
                parkingPriceType: self.check?.parkingPriceType ?? "",
                parkingNightTime: self.check?.parkingNightTime ?? 0,
                parkingNightCost: self.check?.parkingNightCost ?? 0,
                parkingNightPrice: self.check?.parkingNightPrice ?? 0,
                parkingNightPriceType: self.check?.parkingNightPriceType ?? "",
                transferTime: self.check?.transferTime ?? 0,
                transferCost: self.check?.transferCost ?? 0,
                transferPrice: self.check?.transferPrice ?? 0,
                transferPriceType: self.check?.transferPriceType ?? "",
                transferNightTime: self.check?.transferNightTime ?? 0,
                transferNightCost: self.check?.transferNightCost ?? 0,
                transferNightPrice: self.check?.transferNightPrice ?? 0,
                transferNightPriceType: self.check?.transferNightPriceType ?? "",
                waitingTime: self.check?.waitingTime ?? 0,
                waitingCost: self.check?.waitingCost ?? 0,
                waitingPrice: self.check?.waitingPrice ?? 0,
                waitingPriceType: self.check?.waitingPriceType ?? "",
                fixTariffTime: self.check?.fixTariffTime ?? 0,
                fixTariffCost: self.check?.fixTariffCost ?? 0,
                fixTariffPrice: self.check?.fixTariffPrice ?? 0,
                fixTariffPriceType: self.check?.fixTariffPriceType ?? "",
                bookingTime: self.check?.bookingTime ?? 0,
                bookingTimeLeft: self.check?.bookingTimeLeft ?? 0,
                waitingTimeLeft: self.check?.waitingTimeLeft ?? 0,
                finishCost: self.check?.finishCost ?? 0,
                insuranceIncluded: self.check?.insuranceIncluded ?? false,
                riskProfileLevel: self.check?.riskProfileLevel ?? 0,
                riskProfilePoints: self.check?.riskProfilePoints ?? 0,
                dailyPriceType: self.check?.dailyPriceType ?? "",
                dailyCost: self.check?.dailyPrice ?? 0,
                dailyTime: self.check?.dailyCost ?? 0,
                dailyPrice: self.check?.dailyTime ?? 0,
                dailyStatus: self.check?.dailyStatus ?? false,
                discountPercent: self.check?.discountPercent ?? 0,
                discountPrice: self.check?.discountPrice ?? 0,
                percentDiscountPrice: self.check?.percentDiscountPrice ?? 0,
                totalCost: self.check?.totalCostString ?? "",
                totalCostWithDiscount: self.check?.totalCostWithDiscount ?? 0
            )
        )

        return order
    }
    // swiftlint:enable function_body_length
}
