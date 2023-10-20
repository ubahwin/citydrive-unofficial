import SwiftUI
import MapKit

struct MapView: View {
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
        MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        )
                }
            }
        }
        .sheet(isPresented: $openCarDetail) {
            CarView(car: $carSelected)
                .presentationDetents([.height(260)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(260)))
                .presentationCornerRadius(10)
        }
    }
}

#Preview {
    MapView()
}
