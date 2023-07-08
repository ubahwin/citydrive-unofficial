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
    @Published var order: Order = Order()
    
    init() {
        loadOrderList()
    }
    
    func loadOrder(id: String) {
        NetworkManager.shared.getOrder(id: id) { response, error in
            if let orderResponse = response {
                
                let order = Order(
                    amount: orderResponse.check?.totalCostString ?? ""
                )
                
                DispatchQueue.main.async {
                    self.order = order
                }
            }
        }
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
