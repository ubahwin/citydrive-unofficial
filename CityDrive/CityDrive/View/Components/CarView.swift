import Foundation
import SwiftUI

struct CarView: View {
    @ObservedObject var mapVM: MapViewModel

    @State var bottomPanelIsFull = false

    var outOfZone: Bool {
        return mapVM.currentCar?.transferable ?? false
    }

    var body: some View {
        BottomCarSheetView(
            isFull: $bottomPanelIsFull,
            isOpen: $mapVM.openCarDetail,
            outOfZone: outOfZone
        ) {
            VStack {
                CarCardView(
                    mapVM: mapVM,
                    modelInFull: $bottomPanelIsFull
                )
                HStack {
                    GreenFrame {
                        VStack {
                            if bottomPanelIsFull {
                                Text("Поминутный")
                            }
                            Text("\(mapVM.currentCarTariff?.usage.costToString ?? "")/мин")
                                .bold()
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Парковка:")
                                    Text("\(mapVM.currentCarTariff?.parking.costToString ?? "")/мин")
                                }
                                HStack {
                                    Text("Передача:")
                                    Text("\(mapVM.currentCarTariff?.transfer.costToString ?? "")/мин")
                                }
                            }
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.leading)
                    GreenFrame {
                        VStack {
                            Text("Фикс")
                            Spacer()
                            Button("Адрес") {
                                //
                            }
                            .font(.footnote)
                            .buttonStyle(GreenButton())
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.trailing)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: UIDevice.current.hasDynamicIsland ? 50 : 0, trailing: 0))
            .padding(EdgeInsets(top: 10, leading: 0, bottom: outOfZone ? 100 : 50, trailing: 0))
        }
        .ignoresSafeArea()
    }
}

struct GreenFrame<Content: View>: View {
    let content: Content

    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .fill(AppColor.green())
            content
        }
    }
}

struct CarView1_Previews: PreviewProvider {
    static var previews: some View {
        let img = "https://admin.citydrive.ru/static/img/cars/citydrive/chery_tiggo_4/moscow/white_face.png"
        let car = Car(
            id: UUID(),
            location: Point(latitude: 12, longitude: 21),
            img: URL(string: img)!,
            model: "Kia Ria",
            number: CarNumber(number: "a321aa111"),
            transferable: true,
            powerReserveMeters: 45,
            seats: 12,
            remainPath: 43,
            hasTransponder: true,
            boosterSeat: true,
            babySeat: true,
            forSale: true,
            engineWarnUpAvailable: true,
            isElectric: true,
            fuelType: ""
        )
        let tariff = Tariff(usage: 12, parking: 13, transfer: 34)
        let mapVM = MapViewModel()
        mapVM.currentCar = car
        mapVM.currentCarTariff = tariff
        return TabView {
            Group {
                CarView(mapVM: mapVM)
                    .tabItem {
                        Text("tab")
                    }
                CarView(mapVM: mapVM)
                    .tabItem {
                        Text("bar")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct CarView2_Previews: PreviewProvider {
    static var previews: some View {
        let img = "https://admin.citydrive.ru/static/img/cars/citydrive/chery_tiggo_4/moscow/white_face.png"
        let car = Car(
            id: UUID(),
            location: Point(latitude: 12, longitude: 21),
            img: URL(string: img)!,
            model: "Kia Ria",
            number: CarNumber(number: "a321aa111"),
            transferable: false,
            powerReserveMeters: 45,
            seats: 12,
            remainPath: 43,
            hasTransponder: true,
            boosterSeat: true,
            babySeat: true,
            forSale: true,
            engineWarnUpAvailable: true,
            isElectric: true,
            fuelType: ""
        )
        let tariff = Tariff(usage: 12, parking: 13, transfer: 34)
        let mapVM = MapViewModel()
        mapVM.currentCar = car
        mapVM.currentCarTariff = tariff
        return TabView {
            Group {
                CarView(mapVM: mapVM)
                    .tabItem {
                        Text("tab")
                    }
                CarView(mapVM: mapVM)
                    .tabItem {
                        Text("bar")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct SimplePanel_Previews: PreviewProvider {
    static var previews: some View {
        let img = "https://admin.citydrive.ru/static/img/cars/citydrive/chery_tiggo_4/moscow/white_face.png"
        let car = Car(
            id: UUID(),
            location: Point(latitude: 12, longitude: 21),
            img: URL(string: img)!,
            model: "Kia Ria",
            number: CarNumber(number: "a321aa111"),
            transferable: false,
            powerReserveMeters: 45,
            seats: 12,
            remainPath: 43,
            hasTransponder: true,
            boosterSeat: true,
            babySeat: true,
            forSale: true,
            engineWarnUpAvailable: true,
            isElectric: true,
            fuelType: ""
        )
        let mapVM = MapViewModel()
        mapVM.currentCar = car
        return CarView(mapVM: mapVM)
    }
}
