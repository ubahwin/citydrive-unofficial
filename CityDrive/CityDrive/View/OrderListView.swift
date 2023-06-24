//
//  OrderListView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct OrderListView: View {
    var orders: [Order]
    
    var body: some View {
        NavigationStack {
            List(orders) { order in
                NavigationLink(String(order.sum), destination: OrderDetailsView())
            }
            .navigationTitle("История поездок")
        }
    }
}

#Preview {
    OrderListView(orders: [
        Order(date: Date(), sum: 54.1, carName: "nisan"),
        Order(date: Date(), sum: 65, carName: "motiz")
    ])
}
