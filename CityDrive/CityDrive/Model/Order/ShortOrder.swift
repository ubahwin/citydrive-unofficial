import Foundation

struct ShortOrder: Identifiable {
    var id: UUID
    var startedAt: Date
    var amount: String

    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        return dateFormatter.string(from: startedAt)
    }
}

extension OrderListResponse {
    func mapToShortOrder() -> [ShortOrder] {
        let orders = self.orders?.compactMap { orderResponse in
            if
                let orderID = orderResponse.orderID,
                let startedAt = orderResponse.startedAt?.ISO8601ToDate(),
                let amount = orderResponse.amount,

                let orderUUID = UUID(uuidString: orderID) {
                    return ShortOrder(
                        id: orderUUID,
                        startedAt: startedAt,
                        amount: amount
                    )
                }
            return nil
        }
        return orders ?? []
    }
}
