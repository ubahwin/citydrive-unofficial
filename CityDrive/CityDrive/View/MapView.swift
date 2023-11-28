import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var mapVM = MapViewModel()
    @State private var timer = Timer.publish(
        every: 20,
        on: .main,
        in: .common
    ).autoconnect()

    var body: some View {
        ZStack {
            ImperativeMapView(mapVM: mapVM)
                .ignoresSafeArea()
                .onTapGesture {
                    mapVM.openCarDetail = false
                }
            VStack {
                HStack {
                    HStack {
                        BonusButtonView(mapVM: mapVM)
                        RefreshMapButtonView(mapVM: mapVM)
                    }
                    Spacer()
                    UserLocationButtonView(goToUser: $mapVM.goToUser)
                }
                Spacer()
            }
            .padding()
            .shadow(radius: 15)
        }
        .sheet(isPresented: $mapVM.openCarDetail) {
            CarView(mapVM: mapVM)
        }
        .onReceive(timer) { _ in
            mapVM.loadCarsStatus()
        }
    }
}

#Preview {
    MapView()
}
