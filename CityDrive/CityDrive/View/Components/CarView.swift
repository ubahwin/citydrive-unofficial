import Foundation
import SwiftUI

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

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text(mapVM.currentCar?.model ?? "")
                            .font(.title3)
                            .bold()
                        Spacer()
                        CarNumberView(number: mapVM.currentCar?.number)
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
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "fuelpump.fill")
                                    .frame(minWidth: 1, maxWidth: 20)
                                Text("\(mapVM.currentCar?.powerReserveKilometers ?? 0) км")
                            }
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
                            HStack {
                                Image(systemName: "figure.seated.seatbelt")
                                    .frame(minWidth: 1, maxWidth: 20)
                                Text("\(mapVM.currentCar?.seats ?? 0) мест")
                            }
                            if mapVM.currentCar?.hasTransponder ?? false {
                                HStack {
                                    Image(systemName: "road.lanes")
                                        .frame(minWidth: 1, maxWidth: 20)
                                    Text("Транспондер")
                                }
                            }
                            if mapVM.currentCar?.isElectric ?? false {
                                HStack {
                                    Image(systemName: "bolt.fill")
                                        .frame(minWidth: 1, maxWidth: 20)
                                    Text("Электрокарш")
                                }
                            }
                        }
                        .font(.footnote)
                    }
                    .padding(.horizontal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray)
                    VStack {
                        HStack {
                            Text("Использование")
                            Spacer()
                            Text("\(mapVM.currentCarTariff?.usage.costToString ?? "") в мин")
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Парковка")
                            Spacer()
                            Text("\(mapVM.currentCarTariff?.parking.costToString ?? "") в мин")
                        }
                        .padding(.horizontal)
                        .font(.footnote)
                        HStack {
                            Text("Передача")
                            Spacer()
                            Text("\(mapVM.currentCarTariff?.transfer.costToString ?? "") в мин")
                        }
                        .padding(.horizontal)
                        .font(.footnote)
                    }
                }
                .padding()
                Spacer()
            }
        }
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
