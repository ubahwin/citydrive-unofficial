import SwiftUI

struct RefreshMapButtonView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(
            action: {
                withAnimation {
                    mapVM.loadCarsStatus()
                }
            },
            label: {
                if mapVM.carsIsLoaded {
                    Image(systemName: "arrow.clockwise")
                        .frame(width: 20, height: 20)
                } else {
                    ProgressView()
                        .frame(width: 20, height: 20)
                }
            }
        )
        .padding(10)
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : .white)
        .foregroundStyle(colorScheme == .dark ? AppColor.green() : .black)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    RefreshMapButtonView(mapVM: MapViewModel())
}
