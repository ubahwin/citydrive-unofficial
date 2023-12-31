import SwiftUI

struct CarCardView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var openTariffInfo = false
    @Binding var modelInFull: Bool

    var body: some View {
        VStack {
            HStack {
                Text(mapVM.currentCar?.model ?? "")
                    .kerning(0.1)
                    .lineLimit(modelInFull ? 2 : 1)
                    .font(.title2)
                    .bold()
                Spacer()
                CarNumberView(number: mapVM.currentCar?.number)
            }
            HStack {
                VStack {
                    AsyncImage(url: mapVM.currentCar?.img) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("illustration")
                            .resizable()
                            .scaledToFit()
                    }
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

#Preview {
    CarCardView(mapVM: MapViewModel(), modelInFull: Binding.constant(true))
}
