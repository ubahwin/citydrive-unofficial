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
                NavigationLink(destination: OrderDetailsView()) {
                    HStack {
                        Text(order.amount)
                        Spacer()
                        Text(order.startedAtToDate, style: .date)
                    }
                }
            }
            .navigationTitle("orders")
            .refreshable {
                orderVM.loadOrderList()
            }
        }
    }
}

#Preview {
    OrderListView()
}
