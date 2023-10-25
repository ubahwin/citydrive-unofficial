import Foundation
import SwiftUI
import MapKit

struct ImperativeMapView: UIViewRepresentable {
    @ObservedObject var mapVM: MapViewModel
    var locationManager = CLLocationManager()

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ImperativeMapView
        @ObservedObject var mapVM: MapViewModel

        init(parent: ImperativeMapView, mapVM: MapViewModel) {
            self.parent = parent
            self.mapVM = mapVM
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, mapVM: mapVM)
    }

    // TODO: do custom user location button with:
    func goToUserLocation(_ mapView: MKMapView) {
        if let userLocation = mapView.userLocation.location {
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
            mapView.setRegion(region, animated: true)
        }
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()

        updateMapType(mapView)

        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsUserTrackingButton = true

        mapView.delegate = context.coordinator
        return mapView
    }

    func updateMapType(_ mapView: MKMapView) {
        mapView.mapType = mapVM.mapType?.mapType ?? .hybrid
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if !mapVM.mapIsUpdate {
            clearMap(mapView)

            updateCars(mapView)
            updateMapType(mapView)

            mapVM.mapIsUpdate = true
        }

        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            mapView.setRegion(region, animated: true)
        }
    }

    func clearMap(_ mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
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
    var subtitle: String?
    var image: UIImage

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, image: UIImage) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
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
