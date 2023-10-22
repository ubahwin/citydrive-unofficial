import MapKit
import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published var orders: [ShortOrder] = []
    @Published var currentOrder: LargeOrder?
    @Published var currentMiddleOrder: MiddleOrder?

    private let networkManager: NetworkManager

    private var totalCount = 0
    private var page = 0
    private let limit = 15

    init() {
        self.networkManager = NetworkManager()
        loadOrderList()
    }

    func orderHasBonusesReceipt(row: Row) -> Bool {
        if row.rowRight.iconURL != "" || row.rowLeft.iconURL != "" {
            return true
        }
        return false
    }

    func loadMiddleOrder(id: String) {
        networkManager.getMiddleOrder(id: id, version: 20) { response, error in
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

    func loadLargeOrder(id: String) {
        networkManager.getLargeOrder(id: id) { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let orderResponse: LargeOrderResponse = response {
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
