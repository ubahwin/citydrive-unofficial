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
            .onAppear {
                mapVM.loadBonusBalance()
            }
        }
        .sheet(isPresented: $openBonusInfo) {
            Text("Тут инфа про бонусы")
        }
    }
}

#Preview {
    BonusButtonView(mapVM: MapViewModel())
}
