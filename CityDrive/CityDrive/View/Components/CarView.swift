import Foundation
import SwiftUI

struct CarView: View {
    @ObservedObject var mapVM: MapViewModel

    var body: some View {
        NavigationStack {
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
                                        Text("<1 мин")
                                    } else if walktime > 60 {
                                        Text("Слишком долго")
                                    } else {
                                        Text("\(walktime) мин")
                                    }
                                }
                                Button {
                                    mapVM.drawRoadToCurrentCar()
                                } label: {
                                    Image(systemName: "chevron.forward")
                                        .imageScale(.small)
                                        .foregroundStyle(.black)
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
                }
                .padding()
                Spacer(minLength: 10)
                Button {
                    mapVM.bookingCar()
                } label: {
                    if mapVM.currentCar?.transferable ?? false {
                        VStack(spacing: -1) {
                            Text("Забронировать")
                            Text("без права отмены")
                                .opacity(0.6)
                        }
                    } else {
                        Text("Забронировать")
                    }
                }
                .buttonStyle(GreenButton(fixHeight: 50))
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
