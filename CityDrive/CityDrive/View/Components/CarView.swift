import Foundation
import SwiftUI
import TipKit

struct CarView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if mapVM.currentCar?.transferable ?? false {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.red)
                VStack {
                    Text("Вне зоны завершения аренды")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .opacity(0.8)
                        .padding()
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 15)
                    .fill(colorScheme == .dark ? .black : .white)
                    .frame(height: 255)
                VStack {
                    Spacer(minLength: 60)
                    CarInfoView(mapVM: mapVM)
                        .presentationDetents([.height(300)])
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                        .presentationCornerRadius(15)
                        .frame(maxHeight: 275)
                }
            }
        } else {
            CarInfoView(mapVM: mapVM)
                .presentationDetents([.height(255)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(255)))
                .presentationCornerRadius(15)
        }
    }
}

struct CarInfoView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var openTariffInfo = false

    var body: some View {
        VStack {
            HStack {
                Text(mapVM.currentCar?.model ?? "")
                    .font(.title3)
                    .bold()
                    .frame(minWidth: 100)
                Spacer()
                CarNumberView(number: mapVM.currentCar?.number)
                Spacer()
                ZStack {
                    HStack {
                        Text(mapVM.currentCarTariff?.usage.costToString ?? "12,23 P")
                            .bold()
                        Button {
                            openTariffInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .opacity(0.5)
                        }
                    }
                }
                .alert(isPresented: $openTariffInfo) {
                    Alert(
                        title: Text("Тариф"),
                        message: Text(
                            // swiftlint:disable line_length
                            "Использование: \(mapVM.currentCarTariff?.usage.costToString ?? "")/мин\nПарковка: \(mapVM.currentCarTariff?.parking.costToString ?? "")/мин\nПередача: \(mapVM.currentCarTariff?.transfer.costToString ?? "")/мин"
                            // swiftlint:enable line_length
                        ),
                        dismissButton: .default(Text("Хорошо"))
                    )
                }
                .font(.callout)
            }
            HStack {
                AsyncImage(url: mapVM.currentCar?.img) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("illustration")
                        .resizable()
                        .scaledToFit()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Image(systemName: "fuelpump.fill")
                            .frame(minWidth: 1, maxWidth: 20)
                        Text("\(mapVM.currentCar?.powerReserveKilometers ?? 0) км")
                    }
                    .opacity(0.9)

                    HStack {
                        Image(systemName: "figure.walk")
                            .frame(minWidth: 1, maxWidth: 20)
                        if let walktime = mapVM.currentCarWalktime {
                            if walktime == 0 {
                                Text("Меньше минуты")
                            } else if walktime > 60 {
                                Text("Слишком долго")
                            } else {
                                Text("\(walktime) мин")
                            }
                        }
                        Button {
                            mapVM.drawRoad.toggle()
                        } label: {
                            Image(systemName: "chevron.forward")
                                .imageScale(.small)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                        }
                    }
                    .opacity(0.9)

                    HStack {
                        Image(systemName: "figure.seated.seatbelt")
                            .frame(minWidth: 1, maxWidth: 20)
                        Text("\(mapVM.currentCar?.seats ?? 0) мест")
                    }
                    .opacity(0.9)

                    if mapVM.currentCar?.hasTransponder ?? false {
                        HStack {
                            Image(systemName: "road.lanes")
                                .frame(minWidth: 1, maxWidth: 20)
                            Text("Транспондер")
                        }
                        .opacity(0.9)
                    }
                    if mapVM.currentCar?.isElectric ?? false {
                        HStack {
                            Image(systemName: "bolt.fill")
                                .frame(minWidth: 1, maxWidth: 20)
                            Text("Электрокарш")
                        }
                        .opacity(0.9)
                    }
                }
                .font(.footnote)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct CarView_Previews: PreviewProvider {
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
        let mapVM = MapViewModel()
        mapVM.currentCar = car
        return CarView(mapVM: mapVM)
    }
}
