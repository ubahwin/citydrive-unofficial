import SwiftUI
import MapKit

struct OrderDetailsView: View {
    var orderID: String

    @ObservedObject var orderVM: OrdersViewModel

    var body: some View {
        NavigationStack {
            List {
                Section(orderVM.currentMiddleOrder?.details.title ?? "") {
                    ForEach(orderVM.currentMiddleOrder?.details.rows ?? []) { row in
                        HStack {
                            Text(row.rowLeft.text)
                            Spacer()
                            if row.rowRight.iconURL != "" || row.rowLeft.iconURL != "" {
                                BonusImage()
                            }
                            Text(row.rowRight.text)
                        }
                    }
                }

                Section {
                    NavigationLink(destination: { AboutPathView(path: orderVM.currentOrder?.path) }) {
                        Text("Путь")
                    }
                    NavigationLink(destination: { AboutEventsView(events: orderVM.currentOrder?.events) }) {
                        Text("События")
                    }
                    NavigationLink(destination: { AboutCarView(car: orderVM.currentOrder?.car) }) {
                        HStack {
                            Text("Автомобиль")
                            Spacer()
                            Text(orderVM.currentOrder?.car.model ?? "").colorMultiply(.gray)
                        }
                    }
                    NavigationLink(destination: { AboutUserView(user: orderVM.currentOrder?.user) }) {
                        HStack {
                            Text("Пользователь")
                            Spacer()
                            Text(orderVM.currentOrder?.user.firstName ?? "").colorMultiply(.gray)
                        }
                    }
                }

                Section {
                    NavigationLink(destination: { OtherInfoView(otherInfo: orderVM.currentOrder?.otherInfo) }) {
                        Text("Дополнительная информация")
                    }
                }
            }
        }
        .navigationTitle("Детали поездки")
        .onAppear {
            orderVM.loadMiddleOrder(id: orderID)
            orderVM.loadOrder(id: orderID)
        }
    }
}

#Preview {
    OrderDetailsView(orderID: "", orderVM: OrdersViewModel())
}
