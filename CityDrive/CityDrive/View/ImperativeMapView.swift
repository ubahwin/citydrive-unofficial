import Foundation
import SwiftUI
import MapKit
import Combine

// MARK: Representable to UIKit
struct ImperativeMapView: UIViewControllerRepresentable {
    @ObservedObject var mapVM: MapViewModel

    func makeUIViewController(context: Context) -> MapViewController {
        let mapVC = MapViewController()
        mapVC.mapVM = mapVM
        mapVC.mapView = MKMapView()
        mapVC.locationManager = CLLocationManager()
        return mapVC
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {}
}

// MARK: ViewController with map
class MapViewController: UIViewController {
    var mapVM: MapViewModel!

    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    private var currentUserLocationIsLoad: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        mapSetup()
        createSink()

        self.view = mapView
    }

    func renderGreenArea(area: Area) {
        let coordinates: [CLLocationCoordinate2D] = area.points.map { $0.coordinate }
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polygon)
    }

    func updateCars() {
        mapView.removeAnnotations(mapView.annotations)

        for car in mapVM.cars {
            let pin = ImperativeMapPin(car: car)
            mapView.addAnnotation(pin)
        }
    }

    func goToUser() {
        guard let userCoordinate = mapView.userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    func createSink() {
        mapVM.$cars
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.updateCars()
            }
            .store(in: &cancellables)
        mapVM.$greenArea
            .receive(on: DispatchQueue.main)
            .sink { [weak self] greenArea in
                for area in greenArea?.areas ?? [] {
                    self?.renderGreenArea(area: area)
                }
            }
            .store(in: &cancellables)
    }

    func mapSetup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsUserTrackingButton = true

        updateMapInteractions()
        updateMapType()
    }

    func updateMapType() {
        let mapType = mapVM.mapType?.mapType
        mapView.mapType = mapType ?? .standard
    }

    func updateMapInteractions() {
        mapView.isZoomEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = false
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ImperativeMapPin {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ImperativeMapPin")
            annotationView.image = annotation.image
            return annotationView
        }
        if annotation is MKUserLocation {
            let userAnnotationView = UserAnnotationView(
                annotation: annotation,
                reuseIdentifier: "customUserAnnotation"
            )
            userAnnotationView.transform = CGAffineTransform(rotationAngle: 0)
            return userAnnotationView
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.strokeColor = AppColor.green()
            renderer.lineWidth = 5.0
            renderer.fillColor = AppColor.green().withAlphaComponent(0.05)
            return renderer
        }
        return MKOverlayRenderer()
    }

    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if let annotationCar = annotation as? ImperativeMapPin {
            mapVM.openCarDetail = true
            mapVM.setCurrentCar(id: annotationCar.id)
        }
        mapView.deselectAnnotation(annotation, animated: true)
    }
}

// MARK: CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, !currentUserLocationIsLoad {
            let initialLocation = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            let region = MKCoordinateRegion(
                center: initialLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            mapView.setRegion(region, animated: true)
            currentUserLocationIsLoad = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if let userAnnotationView = mapView.view(for: mapView.userLocation) as? UserAnnotationView {
            userAnnotationView.transform = CGAffineTransform(
                rotationAngle: CGFloat(newHeading.trueHeading * .pi / 180.0)
            )
        }
    }
}
