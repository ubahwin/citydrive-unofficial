import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapVM = MapViewModel()

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
        }
        .sheet(isPresented: $mapVM.openCarDetail) {
            CarView(mapVM: mapVM)
                .presentationDetents([.height(300)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
        }
    }
}
