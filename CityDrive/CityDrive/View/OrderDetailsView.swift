import SwiftUI
import MapKit

struct OrderDetailsView: View {
    var orderID: String

    @ObservedObject var orderVM: OrdersViewModel

    var body: some View {
        NavigationStack {
            List {
                Section(orderVM.middleOrder?.details.title ?? "") {
                    ForEach(orderVM.middleOrder?.details.rows ?? []) { row in
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
                    NavigationLink(destination: { AboutPathView(path: orderVM.order?.path) }) {
                        Text("Путь")
                    }
                    NavigationLink(destination: { AboutEventsView(events: orderVM.order?.events) }) {
                        Text("События")
                    }
                    NavigationLink(destination: { AboutCarView(car: orderVM.order?.car) }) {
                        HStack {
                            Text("Автомобиль")
                            Spacer()
                            Text(orderVM.order?.car.model ?? "").colorMultiply(.gray)
                        }
                    }
                    NavigationLink(destination: { AboutUserView(user: orderVM.order?.user) }) {
                        HStack {
                            Text("Пользователь")
                            Spacer()
                            Text(orderVM.order?.user.firstName ?? "").colorMultiply(.gray)
                        }
                    }
                }

                Section {
                    NavigationLink(destination: { OtherInfoView(otherInfo: orderVM.order?.otherInfo) }) {
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
