import SwiftUI
import MapKit

struct MapView: View {
    let heightSheet = 260
    let latRegion = 200
    let lonRegion = 200

    @StateObject private var mapVM = MapViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @Namespace var scope

    @State var carSelected: MKMapItem?
    @State var openCarDetail = false

    var body: some View {
        ZStack {
// =================КАРТА – ЛАГУЧИЙ КРИНЖ==================
            Map(
                position: $camera,
                interactionModes: mapVM.interactions,
                selection: $carSelected,
                scope: scope
            ) {
                ForEach(mapVM.cars, id: \.self) { car in
                    Annotation("", coordinate: car.placemark.coordinate) {
                        Pin(color: .green)
                    }
                }
                UserAnnotation {
                    Pin(color: .blue)
                }
            }
// ========================================================
            VStack {
                HStack {
                    HStack {
                        BonusButtonView(mapVM: mapVM)
                        RefreshMapButtonView(mapVM: mapVM)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    MapUserLocationButton(scope: scope)
                        .buttonBorderShape(.capsule)
                }
            }
            .padding()
        }
        .mapStyle(mapVM.mapType?.mapStyle ?? MapStyle.standard)
        .mapScope(scope)
        .onChange(of: carSelected) { _, new in
            withAnimation {
                openCarDetail = new != nil
                if let coordinate = carSelected?.placemark.coordinate {
                    camera = .region(
                        MKCoordinateRegion(
                            center: coordinate,
                            latitudinalMeters: CLLocationDistance(latRegion),
                            longitudinalMeters: CLLocationDistance(lonRegion)
                        )
        )
                }
            }
        }
        .sheet(isPresented: $openCarDetail) {
            CarView(car: $carSelected)
                .presentationDetents([.height(CGFloat(heightSheet))])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(CGFloat(heightSheet))))
        }
    }
}

#Preview {
    MapView()
}
