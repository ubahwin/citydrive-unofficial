import Foundation
import SwiftUI
import MapKit
import Combine

struct ImperativeMapView: UIViewControllerRepresentable {
    @ObservedObject var mapVM: MapViewModel

    func makeUIViewController(context: Context) -> MapViewController {
        let mapVC = MapViewController()
        mapVC.mapVM = mapVM
        mapVC.mapView = MKMapView()
        return mapVC
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {}
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var mapVM: MapViewModel!
    var mapView: MKMapView!
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        mapSetup()

        view = mapView

        createSink()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ImperativeMapPin else { return nil }

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ImperativeMapPin")
        annotationView.image = annotation.image
        annotationView.canShowCallout = true

        return annotationView
    }

    func updateCars() {
        for car in mapVM.cars {
            let pin = ImperativeMapPin(coordinate: car.coordinate)
            pin.title = car.model
            mapView.addAnnotation(pin)
        }
    }

    func createSink() {
        mapVM.$cars
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateCars()
            }
            .store(in: &cancellables)
    }

    func mapSetup() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsUserTrackingButton = true
    }
}

//    // TODO: do custom user location button with:
//    func goToUserLocation(_ mapView: MKMapView) {
//        if let userLocation = mapView.userLocation.location {
//            let region = MKCoordinateRegion(
//                center: userLocation.coordinate,
//                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//            )
//            mapView.setRegion(region, animated: true)
//        }
//    }
