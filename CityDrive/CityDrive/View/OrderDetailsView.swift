//
//  OrderDetailsView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI
import MapKit

struct OrderDetailsView: View {
    var orderID: String
    
    @ObservedObject var orderVM: OrdersViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Стоимость") {
                    HStack {
                        Text("Использование")
                        Spacer()
                        Text(orderVM.order?.usageCost.costToString() ?? "")
                    }
                    if orderVM.order?.parkingCost != 0 {
                        HStack {
                            Text("Парковка")
                            Spacer()
                            Text(orderVM.order?.parkingCost.costToString() ?? "")
                        }
                    }
                    HStack {
                        Text("Итого")
                        Spacer()
                        Text(orderVM.order?.totalCost.costToString() ?? "")
                    }.bold()
                    if orderVM.order?.bonusCancellationAmount != 0 {
                        HStack {
                            Text("Число списанных бонусов")
                            Spacer()
                            Text(orderVM.order?.bonusCancellationAmount?.costToString() ?? "")
                        }
                    }
                    if orderVM.order?.bonusAccrualAmount != 0 {
                        HStack {
                            Text("Число начисленных бонусов")
                            Spacer()
                            Text(orderVM.order?.bonusAccrualAmount?.costToString() ?? "")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: { AboutPathView(path: orderVM.order?.path, orderVM: orderVM) }) {
                        Text("Путь")
                    }
                }
                
                Section {
                    NavigationLink(destination: { AboutEventsView(events: orderVM.order?.events) }) {
                        Text("События")
                    }
                }
                
                Section {
                    NavigationLink(destination: { AboutCarView(car: orderVM.order?.car) }) {
                        Text("Автомобиль")
                    }
                }
                
                Section {
                    NavigationLink(destination: { AboutUserView(user: orderVM.order?.user) }) {
                        Text("Пользователь")
                    }
                }
                
                Section {
                    NavigationLink(destination: { OtherInfoView(otherInfo: orderVM.order?.otherInfo) }) {
                        Text("Дополнительная информация")
                    }
                }
            }
        }
        .onAppear {
            orderVM.loadOrder(id: orderID)
        }
    }
}

#Preview {
    OrderDetailsView(orderID: "e915e318-d8bd-4505-9a03-16167322e2e9", orderVM: OrdersViewModel())
}
