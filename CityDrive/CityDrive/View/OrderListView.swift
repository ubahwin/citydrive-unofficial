//
//  OrderListView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct OrderListView: View {
    @StateObject private var orderVM = OrdersViewModel()
        
    var body: some View {
        NavigationStack {
            List(orderVM.orders) { order in
                NavigationLink(destination: OrderDetailsView(orderID: order.idString, orderVM: orderVM)) {
                    HStack {
                        Text(order.startedAtToDate, style: .date)
                        Text(order.startedAtToDate, style: .time)
                        Spacer()
                        Text(order.amount).bold()
                    }
                    .padding()
                }
            }
            .navigationTitle("orders")
            .refreshable {
                orderVM.refresh()
            }
            if !orderVM.isLastPage() {
                Button("Загрузить дальше") {
                    orderVM.loadOrderList()
                }
                .padding()
            }
        }
    }
}

#Preview {
    OrderListView()
}
