import MapKit
import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published var orders: [ShortOrder] = []
    @Published var currentOrder: Order?
    @Published var currentMiddleOrder: MiddleOrder?

    private let networkManager: NetworkManager

    private var totalCount = 0
    private var page = 0
    private let limit = 15

    init() {
        self.networkManager = NetworkManager()
        loadOrderList()
    }

    func loadMiddleOrder(id: String) {
        networkManager.getOrder(id: id, version: 20) { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let orderResponse: MiddleOrderResponse = response {
                let order = orderResponse.mapToMiddleOrder()

                DispatchQueue.main.async {
                    self.currentMiddleOrder = order
                }
            }
        }
    }

    func loadOrder(id: String) {
        networkManager.getOrder(id: id) { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let orderResponse: OrderResponse = response {
                let order = orderResponse.mapToOrder()

                DispatchQueue.main.async {
                    self.currentOrder = order
                }
            }
        }
    }

    func loadOrderList() {
        page += 1

        networkManager.getOrders(page: page, limit: limit) { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let shortOrdersResponse: OrderListResponse = response {
                self.totalCount = response?.count ?? 0

                let orders = shortOrdersResponse.mapToShortOrder()

                DispatchQueue.main.async {
                    withAnimation {
                        self.orders.append(contentsOf: orders)
                    }
                }
            }
        }
    }

    func isLastPage() -> Bool {
        return page * limit >= totalCount
    }

    func refresh() {
        withAnimation {
            self.orders = []
        }
        page = 0
        loadOrderList()
    }
}
