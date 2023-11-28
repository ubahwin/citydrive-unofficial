import SwiftUI

struct BonusButtonView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme

    @State private var openBonusInfo = false

    var body: some View {
        VStack {
            Button(
                action: {
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
            .background(colorScheme == .dark ? Color(UIColor.systemBackground) : .white)
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
