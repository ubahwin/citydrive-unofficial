import SwiftUI

struct BonusButtonView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Button(
                action: {
                    // empty
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
    }
}

#Preview {
    BonusButtonView(mapVM: MapViewModel())
}