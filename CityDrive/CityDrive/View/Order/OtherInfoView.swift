//
//  OtherInfoView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI

struct OtherInfoView: View {
    var otherInfo: OtherInfoOrder?
    
    var body: some View {
        List {
            HStack {
                Text("cityName")
                Spacer()
                Text(otherInfo?.cityName ?? "")
            }
            HStack {
                Text("kasko")
                Spacer()
                Text(otherInfo?.kasko.description ?? "")
            }
            HStack {
                Text("success")
                Spacer()
                Text(otherInfo?.success.description ?? "")
            }
            HStack {
                Text("isActive")
                Spacer()
                Text(otherInfo?.isActive.description ?? "")
            }
            HStack {
                Text("orderSource")
                Spacer()
                Text(otherInfo?.orderSource ?? "")
            }
            HStack {
                Text("tariff mode")
                Spacer()
                Text(otherInfo?.tariffMode ?? "")
            }
            HStack {
                Text("tariff package")
                Spacer()
                Text(otherInfo?.tariffPackage ?? "")
            }
            HStack {
                Text("zone expansion")
                Spacer()
                Text(otherInfo?.zoneExpansion ?? "")
            }
            Section("Достижения") {
                ForEach(otherInfo?.achievements ?? []) { achievement in
                    VStack {
                        HStack {
                            Text("type")
                            Spacer()
                            Text(achievement.type)
                        }
                        HStack {
                            Text("name")
                            Spacer()
                            Text(achievement.name)
                        }
                        HStack {
                            Text("amount")
                            Spacer()
                            Text(String(achievement.amount))
                        }
                        HStack {
                            Text("once")
                            Spacer()
                            Text(achievement.once.description)
                        }
                        HStack {
                            Text("properties")
                            Spacer()
                            Text(achievement.properties)
                        }
                        HStack {
                            Text("isInsurance")
                            Spacer()
                            Text(achievement.isInsurance.description)
                        }
                    }
                }
            }
            
            Section {
                VStack {
                    HStack {
                        Text("usageTime")
                        Spacer()
                        Text(otherInfo?.usageTime.description ?? "")
                    }
                    HStack {
                        Text("usageCost")
                        Spacer()
                        Text(otherInfo?.usageCost.description ?? "")
                    }
                    HStack {
                        Text("usagePrice")
                        Spacer()
                        Text(otherInfo?.usagePrice.description ?? "")
                    }
                    HStack {
                        Text("usagePriceType")
                        Spacer()
                        Text(otherInfo?.usagePriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("usageWorkdayTime")
                        Spacer()
                        Text(otherInfo?.usageWorkdayTime.description ?? "")
                    }
                    HStack {
                        Text("usageWorkdayCost")
                        Spacer()
                        Text(otherInfo?.usageWorkdayCost.description ?? "")
                    }
                    HStack {
                        Text("usageWorkdayPrice")
                        Spacer()
                        Text(otherInfo?.usageWorkdayPrice.description ?? "")
                    }
                    HStack {
                        Text("usageWorkdayPriceType")
                        Spacer()
                        Text(otherInfo?.usageWorkdayPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("usageWeekendTime")
                        Spacer()
                        Text(otherInfo?.usageWeekendTime.description ?? "")
                    }
                    HStack {
                        Text("usageWeekendCost")
                        Spacer()
                        Text(otherInfo?.usageWeekendCost.description ?? "")
                    }
                    HStack {
                        Text("usageWeekendPrice")
                        Spacer()
                        Text(otherInfo?.usageWeekendPrice.description ?? "")
                    }
                    HStack {
                        Text("usageWeekendPriceType")
                        Spacer()
                        Text(otherInfo?.usageWeekendPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("chargingTime")
                        Spacer()
                        Text(otherInfo?.chargingTime.description ?? "")
                    }
                    HStack {
                        Text("chargingCost")
                        Spacer()
                        Text(otherInfo?.chargingCost.description ?? "")
                    }
                    HStack {
                        Text("chargingPrice")
                        Spacer()
                        Text(otherInfo?.chargingPrice.description ?? "")
                    }
                    HStack {
                        Text("chargingPriceType")
                        Spacer()
                        Text(otherInfo?.chargingPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("parkingTime")
                        Spacer()
                        Text(otherInfo?.parkingTime.description ?? "")
                    }
                    HStack {
                        Text("parkingCost")
                        Spacer()
                        Text(otherInfo?.parkingCost.description ?? "")
                    }
                    HStack {
                        Text("parkingPrice")
                        Spacer()
                        Text(otherInfo?.parkingPrice.description ?? "")
                    }
                    HStack {
                        Text("parkingPriceType")
                        Spacer()
                        Text(otherInfo?.parkingPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("parkingNightTime")
                        Spacer()
                        Text(otherInfo?.parkingNightTime.description ?? "")
                    }
                    HStack {
                        Text("parkingNightCost")
                        Spacer()
                        Text(otherInfo?.parkingNightCost.description ?? "")
                    }
                    HStack {
                        Text("parkingNightPrice")
                        Spacer()
                        Text(otherInfo?.parkingNightPrice.description ?? "")
                    }
                    HStack {
                        Text("parkingNightPriceType")
                        Spacer()
                        Text(otherInfo?.parkingNightPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("transferTime")
                        Spacer()
                        Text(otherInfo?.transferTime.description ?? "")
                    }
                    HStack {
                        Text("transferCost")
                        Spacer()
                        Text(otherInfo?.transferCost.description ?? "")
                    }
                    HStack {
                        Text("transferPrice")
                        Spacer()
                        Text(otherInfo?.transferPrice.description ?? "")
                    }
                    HStack {
                        Text("transferPriceType")
                        Spacer()
                        Text(otherInfo?.transferPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("transferNightTime")
                        Spacer()
                        Text(otherInfo?.transferNightTime.description ?? "")
                    }
                    HStack {
                        Text("transferNightCost")
                        Spacer()
                        Text(otherInfo?.transferNightCost.description ?? "")
                    }
                    HStack {
                        Text("transferNightPrice")
                        Spacer()
                        Text(otherInfo?.transferNightPrice.description ?? "")
                    }
                    HStack {
                        Text("transferNightPriceType")
                        Spacer()
                        Text(otherInfo?.transferNightPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("waitingTime")
                        Spacer()
                        Text(otherInfo?.waitingTime.description ?? "")
                    }
                    HStack {
                        Text("waitingCost")
                        Spacer()
                        Text(otherInfo?.waitingCost.description ?? "")
                    }
                    HStack {
                        Text("waitingPrice")
                        Spacer()
                        Text(otherInfo?.waitingPrice.description ?? "")
                    }
                    HStack {
                        Text("waitingPriceType")
                        Spacer()
                        Text(otherInfo?.waitingPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("fixTariffTime")
                        Spacer()
                        Text(otherInfo?.fixTariffTime.description ?? "")
                    }
                    HStack {
                        Text("fixTariffCost")
                        Spacer()
                        Text(otherInfo?.fixTariffCost.description ?? "")
                    }
                    HStack {
                        Text("fixTariffPrice")
                        Spacer()
                        Text(otherInfo?.fixTariffPrice.description ?? "")
                    }
                    HStack {
                        Text("fixTariffPriceType")
                        Spacer()
                        Text(otherInfo?.fixTariffPriceType ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("bookingTime")
                        Spacer()
                        Text(otherInfo?.bookingTime.description ?? "")
                    }
                    HStack {
                        Text("bookingTimeLeft")
                        Spacer()
                        Text(otherInfo?.bookingTimeLeft.description ?? "")
                    }
                    HStack {
                        Text("waitingTimeLeft")
                        Spacer()
                        Text(otherInfo?.waitingTimeLeft.description ?? "")
                    }
                    HStack {
                        Text("finishCost")
                        Spacer()
                        Text(otherInfo?.finishCost.description ?? "")
                    }
                    HStack {
                        Text("insuranceIncluded")
                        Spacer()
                        Text(otherInfo?.insuranceIncluded.description ?? "")
                    }
                }
                VStack {
                    HStack {
                        Text("dailyPriceType")
                        Spacer()
                        Text(otherInfo?.dailyPriceType ?? "")
                    }
                    HStack {
                        Text("dailyCost")
                        Spacer()
                        Text(otherInfo?.dailyCost.description ?? "")
                    }
                    HStack {
                        Text("dailyTime")
                        Spacer()
                        Text(otherInfo?.dailyTime.description ?? "")
                    }
                    HStack {
                        Text("dailyPrice")
                        Spacer()
                        Text(otherInfo?.dailyPrice.description ?? "")
                    }
                    HStack {
                        Text("dailyStatus")
                        Spacer()
                        Text(otherInfo?.dailyStatus.description ?? "")
                    }
                }
            }
            
            Section {
                HStack {
                    Text("discountPercent")
                    Spacer()
                    Text(otherInfo?.discountPercent.description ?? "")
                }
                HStack {
                    Text("discountPrice")
                    Spacer()
                    Text(otherInfo?.discountPrice.description ?? "")
                }
                HStack {
                    Text("percentDiscountPrice")
                    Spacer()
                    Text(otherInfo?.percentDiscountPrice.description ?? "")
                }
                HStack {
                    Text("totalCost")
                    Spacer()
                    Text(otherInfo?.totalCost ?? "")
                }
                HStack {
                    Text("totalCostWithDiscount")
                    Spacer()
                    Text(otherInfo?.totalCostWithDiscount.description ?? "")
                }
            }
            
            Section {
                HStack {
                    Text("riskProfileLevel")
                    Spacer()
                    Text(otherInfo?.riskProfileLevel.description ?? "")
                }
                HStack {
                    Text("riskProfilePoints")
                    Spacer()
                    Text(otherInfo?.riskProfilePoints.description ?? "")
                }
            }
            
            Section("Валюта") {
                HStack {
                    Text("code")
                    Spacer()
                    Text(otherInfo?.currency.code ?? "")
                }
                HStack {
                    Text("symbol")
                    Spacer()
                    Text(otherInfo?.currency.symbol ?? "")
                }
            }
            
            Section("Транзакция") {
                HStack {
                    Text("status")
                    Spacer()
                    Text(otherInfo?.transactionInfo.status ?? "")
                }
                HStack {
                    Text("isCreated")
                    Spacer()
                    Text(otherInfo?.transactionInfo.isCreated.description ?? "")
                }
                HStack {
                    Text("data")
                    Spacer()
                    Text(otherInfo?.transactionInfo.data ?? "")
                }
            }
            
            Section("Программа лояльности") {
                HStack {
                    Text("programType")
                    Spacer()
                    Text(otherInfo?.loyaltyProgram.programType ?? "")
                }
                HStack {
                    Text("status")
                    Spacer()
                    Text(otherInfo?.loyaltyProgram.status ?? "")
                }
                HStack {
                    Text("percent")
                    Spacer()
                    Text(otherInfo?.loyaltyProgram.percent.description ?? "")
                }
            }
        }
    }
}

#Preview {
    OtherInfoView()
}
