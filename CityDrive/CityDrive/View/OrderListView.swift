import SwiftUI

struct OrderListView: View {
    @ObservedObject var orderVM: OrdersViewModel

    var body: some View {
        NavigationStack {
            Form {
                if orderVM.orders.isEmpty {
                    List(0..<10) { _ in
                        HStack {
                            Text("mock")
                            Text("mock")
                            Spacer()
                            Text("mock")
                        }
                        .padding()
                    }
                    .redacted(reason: .placeholder)
                }
                List(orderVM.orders) { order in
                    NavigationLink(destination: OrderDetailsView(orderID: order.id.uuidString, orderVM: orderVM)) {
                        HStack {
                            Text(order.date)
                            Text(order.startedAt, style: .time)
                            Spacer()
                            Text(order.amount).bold()
                        }
                        .padding()
                    }
                }
                if !orderVM.isLastPage() {
                    Text("Загрузка...")
                        .onAppear {
                            orderVM.loadOrderList()
                        }
                }
            }
            .navigationTitle("История поездок")
            .refreshable {
                orderVM.refresh()
            }
        }
    }
}

#Preview {
    OrderListView(orderVM: OrdersViewModel())
}
