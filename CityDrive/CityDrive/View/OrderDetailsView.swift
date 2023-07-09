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
        VStack {
            Text(orderVM.order?.cityName ?? "")
        }
        .onAppear {
            orderVM.loadOrder(id: orderID)
        }
    }
}

#Preview {
    OrderDetailsView(orderID: "e915e318-d8bd-4505-9a03-16167322e2e9", orderVM: OrdersViewModel())
}
