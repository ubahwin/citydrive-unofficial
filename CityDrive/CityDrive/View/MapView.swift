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
            for car in mapVM.allCars {
                let annotationCoordinate = CLLocationCoordinate2D(latitude: car.lat, longitude: car.lon)
                let annotation = PinAnnotation(coordinate: annotationCoordinate, title: car.model)
                mapView.addAnnotation(annotation)
            }

            print("update")
        }
    }
}

class PinAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?

    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}

// =================КАРТА – ЛАГУЧИЙ КРИНЖ==================
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
