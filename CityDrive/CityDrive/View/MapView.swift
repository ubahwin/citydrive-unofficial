import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapVM = MapViewModel()

    var body: some View {
        ZStack {
            ImperativeMapView(mapVM: mapVM)
                .ignoresSafeArea()
            VStack {
                HStack {
                    HStack {
                        BonusButtonView(mapVM: mapVM)
                        RefreshMapButtonView(mapVM: mapVM)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}
