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

    var bottomPanel: UIView!
    var mapView: MKMapView!
    var locationManager: CLLocationManager!

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        mapSetup()
        createSink()

        bottomPanel = UIView(frame: CGRect(
            x: 0,
            y: view.bounds.height - 100,
            width: view.bounds.width,
            height: 100)
        )
        bottomPanel.backgroundColor = UIColor.lightGray
        view.addSubview(bottomPanel)

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
            let color: UIColor = car.transferable ? AppColor.red() : AppColor.green()

            let pin = ImperativeMapPin(
                coordinate: car.location.coordinate,
                title: car.model,
                color: color
            )

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
//        mapView.showsUserTrackingButton = true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ImperativeMapPin {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ImperativeMapPin")

            annotationView.image = annotation.image
            annotationView.canShowCallout = true

            return annotationView
        }
        if annotation is MKUserLocation {
            return UserAnnotationView(annotation: annotation, reuseIdentifier: "customUserAnnotation")
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

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            let bottomPanelLabel = UILabel(frame: CGRect(
                x: 0,
                y: 0,
                width: bottomPanel.bounds.width,
                height: bottomPanel.bounds.height)
            )
            bottomPanelLabel.text = annotation.title ?? "Нет названия"
            bottomPanelLabel.textAlignment = .center
            bottomPanel.addSubview(bottomPanelLabel)

            bottomPanel.isHidden = false
        }
    }
}

extension MapViewController: CLLocationManagerDelegate { }
