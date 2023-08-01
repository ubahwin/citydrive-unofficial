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
                Section(orderVM.middleOrder?.details.title ?? "") {
                    ForEach(orderVM.middleOrder?.details.rows ?? []) { row in
                        HStack {
                            Text(row.rowLeft.text)
                            Spacer()
                            if row.rowRight.iconURL != "" {
                                AsyncImage(url: URL(string: row.rowRight.iconURL)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            if row.rowLeft.iconURL != "" {
                                AsyncImage(url: URL(string: row.rowLeft.iconURL)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            Text(row.rowRight.text)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: { AboutPathView(path: orderVM.order?.path) }) {
                        Text("Путь")
                    }
                    NavigationLink(destination: { AboutEventsView(events: orderVM.order?.events) }) {
                        Text("События")
                    }
                    NavigationLink(destination: { AboutCarView(car: orderVM.order?.car) }) {
                        HStack {
                            Text("Автомобиль")
                            Spacer()
                            Text(orderVM.order?.car.model ?? "").colorMultiply(.gray)
                        }
                    }
                    NavigationLink(destination: { AboutUserView(user: orderVM.order?.user) }) {
                        HStack {
                            Text("Пользователь")
                            Spacer()
                            Text(orderVM.order?.user.firstName ?? "").colorMultiply(.gray)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: { OtherInfoView(otherInfo: orderVM.order?.otherInfo) }) {
                        Text("Дополнительная информация")
                    }
                }
            }
        }
        .navigationTitle("Детали поездки")
        .onAppear {
            orderVM.loadMiddleOrder(id: orderID)
            orderVM.loadOrder(id: orderID)
        }
    }
}

#Preview {
    OrderDetailsView(orderID: "e915e318-d8bd-4505-9a03-16167322e2e9", orderVM: OrdersViewModel())
}
