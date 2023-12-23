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
                            if orderVM.orderHasBonusesReceipt(row: row) {
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

                Section("payback") {
                    SimpleCellView(
                        name: "С каждого по",
                        value: "\(orderVM.duty) ₽"
                    )
                    Stepper(
                        "Кол-во людей: \(orderVM.peopleCount)",
                        value: $orderVM.peopleCount, in: 2...5
                    )
                    .onChange(of: orderVM.peopleCount) {
                        orderVM.calculateDuty()
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
            orderVM.loadLargeOrder(id: orderID)
        }
    }
}

#Preview {
    OrderDetailsView(orderID: "", orderVM: OrdersViewModel())
}
