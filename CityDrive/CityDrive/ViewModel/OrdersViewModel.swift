//
//  OrdersViewModel.swift
//  CityDrive
//
//  Created by Иван Вдовин on 08.07.2023.
//

import Foundation
import MapKit

class OrdersViewModel: ObservableObject {
    @Published var orders: [ShortOrder] = []
    
    init() {
        loadOrderList()
    }
    
    func loadOrderList() {
        NetworkManager.shared.getOrders { response, error in
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
                    self.orders = orders
                }
            }
        }
    }
}
