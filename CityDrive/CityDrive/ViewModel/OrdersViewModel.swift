//
//  OrdersViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation
import MapKit
import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published var orders: [ShortOrder] = []
    @Published var order: Order?
    
    @Published var startAddress = ""
    @Published var finishAddress = ""
    
    private var networkManager: NetworkManager
        
    private var totalCount = 0
    private var page = 0
    private let limit = 15
    
    init() {
        self.networkManager = NetworkManager()
        loadOrderList()
    }
    
    func loadOrder(id: String) {
        networkManager.getOrder(id: id) { response, error in
            if let orderResponse = response {
                let events = orderResponse.events?.compactMap { event in
                    if
                        let state = event.state,
                        let name = event.name,
                        let status = event.status,
                        let time = event.time,
                        let lat = event.lat,
                        let lon = event.lon,
                        let isPassive = event.isPassive,
                        let cost = event.cost,
                        let duration = event.duration,
                        let userLat = event.userLat,
                        let userLon = event.userLon {
                        return EventOrder(state: state,
                                          name: name,
                                          status: status,
                                          time: time,
                                          lat: lat,
                                          lon: lon,
                                          isPassive: isPassive,
                                          cost: cost,
                                          duration: duration,
                                          userLat: userLat,
                                          userLon: userLon)
                    }
                    return nil
                }
                
                let achievements = orderResponse.achievements?.compactMap { achievement in
                    if
                        let type = achievement.type,
                        let name = achievement.name,
                        let amount = achievement.amount,
                        let once = achievement.once,
                        let properties = achievement.properties,
                        let isInsurance = achievement.isInsurance {
                        return AchievementOrder(type: type,
                                                name: name,
                                                amount: amount,
                                                once: once,
                                                properties: properties,
                                                isInsurance: isInsurance)
                    }
                    return nil
                }
                
                let order = Order(
                    usageCost: (orderResponse.check?.usageCost ?? 0).costToDouble(),
                    car: CarOrder(
                        id: orderResponse.carID ?? "",
                        number: orderResponse.carNumber ?? "",
                        model: orderResponse.carModel ?? "",
                        img: orderResponse.carImg ?? "",
                        odometer: Odometer(
                            atStart: orderResponse.carOdometer?.atStart ?? 0,
                            atFinish: orderResponse.carOdometer?.atFinish ?? 0)
                    ),
                    events: events ?? [],
                    path: PathOrder(
                        start: LocateOrder(
                            lat: orderResponse.path?.start?.lat ?? 0,
                            lon: orderResponse.path?.start?.lon ?? 0),
                        finish: LocateOrder(
                            lat: orderResponse.path?.finish?.lat ?? 0,
                            lon: orderResponse.path?.finish?.lon ?? 0),
                        period: PeriodOrder(
                            start: orderResponse.period?.start ?? "",
                            finish: orderResponse.period?.finish ?? "")
                    ),
                    user: UserOrder(userID: orderResponse.user?.userID ?? "",
                                    firstName: orderResponse.user?.firstName ?? "",
                                    lastName: orderResponse.user?.lastName ?? "",
                                    fullName: orderResponse.user?.fullName ?? "",
                                    middleName: orderResponse.user?.middleName ?? "",
                                    email: orderResponse.user?.email ?? "",
                                    phone: orderResponse.user?.phone ?? 0),
                    otherInfo: OtherInfoOrder(
                        currency: Currency(code: orderResponse.currency?.currencyCode ?? "", symbol: orderResponse.currency?.currencySymbol ?? ""),
                        kasko: orderResponse.kasko ?? false,
                        orderSource: orderResponse.orderSource ?? "",
                        loyaltyProgram: LoyaltyProgram(
                            programType: orderResponse.loyaltyProgram?.programType ?? "",
                            status: orderResponse.loyaltyProgram?.status ?? "",
                            percent: orderResponse.loyaltyProgram?.percent ?? 0
                        ),
                        timezoneOffset: orderResponse.timezoneOffset ?? 0,
                        achievements: achievements ?? [],
                        transactionInfo: TransactionInfo(
                            status: orderResponse.transactionInfo?.status ?? "",
                            isCreated: orderResponse.transactionInfo?.transactionInfoData?.isCreated ?? false,
                            data: orderResponse.transactionInfo?.data ?? "",
                            dataPaymentResponses: orderResponse.transactionInfo?.transactionInfoData?.dataPaymentResponses ?? "",
                            paymentResponses: orderResponse.transactionInfo?.transactionInfoData?.paymentResponses ?? ""),
                        cityName: orderResponse.cityName ?? "",
                        tariffPackage: orderResponse.tariffPackage ?? "",
                        zoneExpansion: orderResponse.zoneExpansion ?? "",
                        tariffMode: orderResponse.tariffMode ?? "",
                        success: orderResponse.success ?? false,
                        isActive: orderResponse.isActive ?? false,
                        usageTime: orderResponse.check?.usageTime ?? 0,
                        usageCost: orderResponse.check?.usageCost ?? 0,
                        usagePrice: orderResponse.check?.usagePrice ?? 0,
                        usagePriceType: orderResponse.check?.usagePriceType ?? "",
                        usageWorkdayTime: orderResponse.check?.usageWorkdayTime ?? 0,
                        usageWorkdayCost: orderResponse.check?.usageWorkdayCost ?? 0,
                        usageWorkdayPrice: orderResponse.check?.usageWorkdayPrice ?? 0,
                        usageWorkdayPriceType: orderResponse.check?.usageWorkdayPriceType ?? "",
                        usageWeekendTime: orderResponse.check?.usageWeekendTime ?? 0,
                        usageWeekendCost: orderResponse.check?.usageWeekendCost ?? 0,
                        usageWeekendPrice: orderResponse.check?.usageWeekendPrice ?? 0,
                        usageWeekendPriceType: orderResponse.check?.usageWeekendPriceType ?? "",
                        chargingTime: orderResponse.check?.chargingTime ?? 0,
                        chargingCost: orderResponse.check?.chargingCost ?? 0,
                        chargingPrice: orderResponse.check?.chargingPrice ?? 0,
                        chargingPriceType: orderResponse.check?.chargingPriceType ?? "",
                        parkingTime: orderResponse.check?.parkingTime ?? 0,
                        parkingCost: orderResponse.check?.parkingCost ?? 0,
                        parkingPrice: orderResponse.check?.parkingPrice ?? 0,
                        parkingPriceType: orderResponse.check?.parkingPriceType ?? "",
                        parkingNightTime: orderResponse.check?.parkingNightTime ?? 0,
                        parkingNightCost: orderResponse.check?.parkingNightCost ?? 0,
                        parkingNightPrice: orderResponse.check?.parkingNightPrice ?? 0,
                        parkingNightPriceType: orderResponse.check?.parkingNightPriceType ?? "",
                        transferTime: orderResponse.check?.transferTime ?? 0,
                        transferCost: orderResponse.check?.transferCost ?? 0,
                        transferPrice: orderResponse.check?.transferPrice ?? 0,
                        transferPriceType: orderResponse.check?.transferPriceType ?? "",
                        transferNightTime: orderResponse.check?.transferNightTime ?? 0,
                        transferNightCost: orderResponse.check?.transferNightCost ?? 0,
                        transferNightPrice: orderResponse.check?.transferNightPrice ?? 0,
                        transferNightPriceType: orderResponse.check?.transferNightPriceType ?? "",
                        waitingTime: orderResponse.check?.waitingTime ?? 0,
                        waitingCost: orderResponse.check?.waitingCost ?? 0,
                        waitingPrice: orderResponse.check?.waitingPrice ?? 0,
                        waitingPriceType: orderResponse.check?.waitingPriceType ?? "",
                        fixTariffTime: orderResponse.check?.fixTariffTime ?? 0,
                        fixTariffCost: orderResponse.check?.fixTariffCost ?? 0,
                        fixTariffPrice: orderResponse.check?.fixTariffPrice ?? 0,
                        fixTariffPriceType: orderResponse.check?.fixTariffPriceType ?? "",
                        bookingTime: orderResponse.check?.bookingTime ?? 0,
                        bookingTimeLeft: orderResponse.check?.bookingTimeLeft ?? 0,
                        waitingTimeLeft: orderResponse.check?.waitingTimeLeft ?? 0,
                        finishCost: orderResponse.check?.finishCost ?? 0,
                        insuranceIncluded: orderResponse.check?.insuranceIncluded ?? false,
                        riskProfileLevel: orderResponse.check?.riskProfileLevel ?? 0,
                        riskProfilePoints: orderResponse.check?.riskProfilePoints ?? 0,
                        dailyPriceType: orderResponse.check?.dailyPriceType ?? "",
                        dailyCost: orderResponse.check?.dailyPrice ?? 0,
                        dailyTime: orderResponse.check?.dailyCost ?? 0,
                        dailyPrice: orderResponse.check?.dailyTime ?? 0,
                        dailyStatus: orderResponse.check?.dailyStatus ?? false,
                        discountPercent: orderResponse.check?.discountPercent ?? 0,
                        discountPrice: orderResponse.check?.discountPrice ?? 0,
                        percentDiscountPrice: orderResponse.check?.percentDiscountPrice ?? 0,
                        totalCost: orderResponse.check?.totalCostString ?? "",
                        totalCostWithDiscount: orderResponse.check?.totalCostWithDiscount ?? 0
                    )
                )
                
                DispatchQueue.main.async {
                    self.order = order
                    self.reverseGeocodeStart()
                    self.reverseGeocodeFinish()
                }
            }
        }
    }
    
    func loadOrderList() {
        page += 1

        networkManager.getOrders(page: page, limit: limit) { response, error in
            self.totalCount = response?.count ?? 0
            
            let orders = response?.orders?.compactMap { orderResponse in
                if
                    let orderID = orderResponse.orderID,
                    let startedAt = orderResponse.startedAt,
                    let amount = orderResponse.amount,
                    
                    let orderUUID = UUID(uuidString: orderID) {
                        return ShortOrder(id: orderUUID, startedAt: startedAt, amount: amount)
                    }
                return nil
            }
            
            if let orders = orders {
                DispatchQueue.main.async {
                    withAnimation {
                        self.orders.append(contentsOf: orders)
                    }
                }
            }
        }
    }
    
    func isLastPage() -> Bool {
        return page * limit >= totalCount
    }
    
    func refresh() {
        withAnimation {
            self.orders = []
        }
        page = 0
        loadOrderList()
    }
    
    func reverseGeocodeStart() {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(CLLocation(latitude: order?.path.start.lat ?? 0, longitude: order?.path.start.lon ?? 0)) { (placemarks, error) in
            if let error = error {
                print("Ошибка геокодирования для начальной точки: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let address = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
                self.startAddress = address
            }
        }
        
    }
    func reverseGeocodeFinish() {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(CLLocation(latitude: order?.path.finish.lat ?? 0, longitude: order?.path.finish.lon ?? 0)) { (placemarks, error) in
            if let error = error {
                print("Ошибка геокодирования для конечной точки: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let address = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
                self.finishAddress = address
            }
        }
    }
}
