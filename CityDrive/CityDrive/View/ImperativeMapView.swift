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
        mapVC.locationManager = CLLocationManager()
        return mapVC
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {}
}

class MapViewController: UIViewController {
    var mapVM: MapViewModel!

    var mapView: MKMapView!
    var locationManager: CLLocationManager!

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        mapSetup()
        createSink()

        view = mapView
    }

    func renderGreenArea(area: Area) {
        let coordinates: [CLLocationCoordinate2D] = area.points.map { $0.coordinate }
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polygon)
    }

    func updateCars() {
        mapView.removeAnnotations(mapView.annotations)

        for car in mapVM.cars {
            let image = car.transferable ? UIImage(named: "red-pin") : UIImage(named: "green-pin")
            let pin = ImperativeMapPin(
                coordinate: car.location.coordinate,
                image: image?.resizePin(height: 20)
            )

            pin.title = car.model

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
                self.goToUser()
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

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsUserTrackingButton = true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ImperativeMapPin else { return nil }

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ImperativeMapPin")
        annotationView.image = annotation.image
        annotationView.canShowCallout = true

        return annotationView
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.strokeColor = AppColor.green()
            renderer.lineWidth = 5.0
            renderer.fillColor = AppColor.green().withAlphaComponent(0.06)
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension MapViewController: CLLocationManagerDelegate { }
