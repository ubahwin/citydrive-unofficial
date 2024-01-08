import SwiftUI

struct BonusButtonView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme

    @State private var openBonusInfo = false

    var body: some View {
        VStack {
            Button(
                action: {
                    mapVM.openCarDetail = false
                    openBonusInfo = true
                },
                label: {
                    HStack {
                        Text(mapVM.bonusBalance)
                        BonusImage()
                    }
                }
            )
            .padding(10)
            .background(colorScheme == .dark ? .black : .white)
            .foregroundStyle(colorScheme == .dark ? AppColor.green() : .black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .sheet(isPresented: $openBonusInfo) {
            BonusInfoView(mapVM: mapVM)
                .presentationDragIndicator(.visible)
        }
    }
}

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeWidth = 4.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .opacity(0.4)
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(AppColor.purple(), style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack {
                Text("2079")
                Text("км")
                    .foregroundStyle(.gray)
            }
        }
    }
}

struct BonusInfoView: View {
    @ObservedObject var mapVM: MapViewModel

    @State var passedKm = 2079.0

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: 0x21233c))
                .ignoresSafeArea()
                .clipShape(.rect(cornerRadius: 15))
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .clipShape(.rect(cornerRadius: 15))
                .offset(y: 180)

            VStack {
                VStack {
                    HStack {
                        Text(mapVM.bonusBalance.description)
                            .font(.title)
                            .bold()
                        BonusImage()
                    }
                    Toggle("Списывать драйв бонусы", isOn: $mapVM.spendingBonuses)
                        .onChange(of: mapVM.spendingBonuses) { _, newValue in
                            mapVM.spendingBonuses(newValue)
                        }
                }
                .foregroundStyle(.white)
                .padding()
                .padding(.bottom, 80)

                VStack {
                    Text("Человек-машина")
                        .font(.title2)
                        .bold()
                    HStack {
                        ProgressView(value: passedKm, total: 4000)
                            .progressViewStyle(GaugeProgressStyle())
                            .frame(width: 80, height: 80)
                            .contentShape(Rectangle())
                        Text("Вы проехали \(Int(passedKm)) км")
                            .frame(width: 250)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    BonusButtonView(mapVM: MapViewModel())
}

#Preview {
    BonusInfoView(mapVM: MapViewModel())
}
