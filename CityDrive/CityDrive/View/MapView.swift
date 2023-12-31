import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapVM: MapViewModel
    @State private var timer = Timer.publish(
        every: 30,
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
                        if !mapVM.carsIsLoaded {
                            ProgressView()
                                .dynamicTypeSize(.accessibility1)
                                .shadow(radius: 10)
                                .padding(.horizontal)
                        }
                    }
                    Spacer()
                    UserLocationButtonView(goToUser: $mapVM.goToUser)
                }
                Spacer()
            }
            .padding()
            .shadow(radius: 15)
            if mapVM.openCarDetail {
                CarView(mapVM: mapVM)
            }
        }
        .onReceive(timer) { _ in
            if !mapVM.openCarDetail {
                mapVM.loadCarsStatus()
            }
        }
    }
}

#Preview {
    MapView(mapVM: MapViewModel())
}
