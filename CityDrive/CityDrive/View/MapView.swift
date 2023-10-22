import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @StateObject private var mapVM = MapViewModel()

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        @ObservedObject var mapVM: MapViewModel

        init(parent: MapView, mapVM: MapViewModel) {
            self.parent = parent
            self.mapVM = mapVM
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, mapVM: mapVM)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if mapView.annotations.isEmpty {
            updateCars(mapView)
            print("update")
        }

        if !mapVM.carsIsLoaded {
            mapView.removeAnnotations(mapView.annotations)
            print("remove")
        }
    }

    func updateCars(_ mapView: MKMapView) {
        for car in mapVM.cars {
            let pin = MKPointAnnotation()
            pin.coordinate = car.coordinate
            pin.title = car.model
            mapView.addAnnotation(pin)
        }
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D, title: String?, image: UIImage?) {
        self.coordinate = coordinate
        self.title = title
        self.image = image
        super.init()
    }
}

// ================== SwiftUI (iOS 17) ==== КАРТА – ЛАГУЧИЙ КРИНЖ ==================
//        ZStack {
//            Map(
//                position: $camera,
//                interactionModes: mapVM.interactions,
//                selection: $carSelected,
//                scope: scope
//            ) {
//                ForEach(mapVM.currentCars) { car in
//                    Annotation("", coordinate: car.coordinate) {
//                        Pin(color: .green)
//                    }
//                }
//                UserAnnotation {
//                    Pin(color: .blue)
//                }
//            }
//            VStack {
//                HStack {
//                    HStack {
//                        BonusButtonView(mapVM: mapVM)
//                        RefreshMapButtonView(mapVM: mapVM)
//                    }
//                    Spacer()
//                }
//                Spacer()
//                HStack {
//                    Spacer()
//                    MapUserLocationButton(scope: scope)
//                        .buttonBorderShape(.capsule)
//                }
//            }
//            .padding()
//        }
//        .mapStyle(mapVM.mapType?.mapStyle ?? MapStyle.standard)
//        .mapScope(scope)
//        .onMapCameraChange(frequency: MapCameraUpdateFrequency.onEnd) {
//            mapVM.updateCurrentCars()
//        }
// ========================================================
