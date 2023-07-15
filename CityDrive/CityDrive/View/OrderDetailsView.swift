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
                Section("Основная информация") {
                    HStack {
                        Text("Использование")
                        Spacer()
                        Text(orderVM.order?.usageCost.costToString() ?? "")
                    }
                }
                
                Section {
                    NavigationLink(destination: { AboutPathView(path: orderVM.order?.path) }) {
                        Text("Путь")
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
