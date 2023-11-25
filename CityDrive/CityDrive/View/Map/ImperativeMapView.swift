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

        var carAnnotations = [ImperativeMapPin]()

        for car in mapVM.cars {
            let pin = ImperativeMapPin(
                id: car.id,
                coordinate: car.location.coordinate,
                transferable: car.transferable
            )
            carAnnotations.append(pin)
        }

        mapView.addAnnotations(carAnnotations)
    }

    func goToUser() {
        guard let userCoordinate = mapView.userLocation.location?.coordinate else { return }
        goTo(coordinate: userCoordinate)
    }

    func goTo(
        coordinate: CLLocationCoordinate2D,
        offsetLat: CLLocationDegrees? = nil,
        offsetLon: CLLocationDegrees? = nil
    ) {
        var lat = coordinate.latitude
        var lon = coordinate.longitude

        if let offset = offsetLat {
            lat += offset
        }
        if let offset = offsetLon {
            lon += offset
        }

        let сenter = CLLocationCoordinate2D(latitude: lat, longitude: lon)

        let region = MKCoordinateRegion(
            center: сenter,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
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
        mapVM.$goToUser
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.goToUser()
            }
            .store(in: &cancellables)
        mapVM.$openCarDetail
            .receive(on: DispatchQueue.main)
            .sink { [self] flag in
                if !flag {
                    getAwayFromCurCar()
                }
            }
            .store(in: &cancellables)
        mapVM.$drawRoad
            .receive(on: DispatchQueue.main)
            .sink { [self] flag in
                if flag {
                    drawRoad(route: mapVM.routeToCurCar)
                } else {
                    removeRoad(route: mapVM.routeToCurCar)
                    changePinTappedCar(view: mapVM.currentCarAnnotation)
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

    func calculateWalkingTime(from user: Point) {
        guard let destination = mapVM.currentCar?.location.coordinate else {
            return
        }

        let request = MKDirections.Request()

        let sourcePlacemark = MKPlacemark(coordinate: user.coordinate, addressDictionary: nil)
        request.source = MKMapItem(placemark: sourcePlacemark)

        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .walking
        let directions = MKDirections(request: request)

        directions.calculate { [self] (response, _) in
            guard let response = response else { return }

            let ETA = response.routes[0].expectedTravelTime
            let minutes = Int(ETA / 60)

            mapVM.currentCarWalktime = minutes
            mapVM.routeToCurCar = response.routes[0]
        }
    }

    func drawRoad(route: MKRoute?) {
        guard let route = route else { return }

        mapView.addOverlay(route.polyline, level: .aboveRoads)

        if let endCoordinate = route.steps.first?.polyline.coordinate {
            let startCoordinate = route.polyline.coordinate
            goToTwoPoints(
                point1: Point(coordinate: startCoordinate),
                point2: Point(coordinate: endCoordinate)
            )
        }

        mapVM.currentCarAnnotation?.image = UIImage.pinGotoCar.resizePin(height: 50, width: 30)
    }

    func getAwayFromCurCar() {
        removeRoad(route: mapVM.routeToCurCar)
        mapView.deselectAnnotation(nil, animated: false)
    }

    func removeRoad(route: MKRoute?) {
        guard let line = route?.polyline else {
            return
        }
        mapView.removeOverlay(line)
    }

    func goToTwoPoints(point1: Point, point2: Point) {
        // TODO: Доделать реализацию перемещения между двумя точками картиночку красиву
//        let region = MKCoordinateRegion(center: center, span: span)
//        mapView.setRegion(region, animated: true)
    }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    // MARK: view for annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ImperativeMapPin {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "ImperativeMapPin")
            annotationView.image = annotation.image
            return annotationView
        }
        if annotation is MKUserLocation {
            let userAnnotationView = UserAnnotationView(
                annotation: annotation,
                reuseIdentifier: "UserAnnotationView"
            )
            return userAnnotationView
        }
        return nil
    }

    // MARK: renderer poligon
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.strokeColor = AppColor.green()
            renderer.lineWidth = 5.0
            renderer.fillColor = AppColor.green().withAlphaComponent(0.05)
            return renderer
        }

        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = AppColor.purple()
        renderer.lineWidth = 3.0
        return renderer
    }

    // MARK: did select annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? ImperativeMapPin {
            goTo(coordinate: annotation.coordinate, offsetLat: -0.001)

            mapVM.currentCarAnnotation = view
            mapVM.openCarDetail = true
            mapVM.setCurrentCar(id: annotation.id)
            calculateWalkingTime(from: Point(coordinate: mapView.userLocation.coordinate))

            changePinTappedCar(view: view)
            view.centerOffset.y -= 20
        }
    }

    // MARK: did deselect annotation
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let annotation = view.annotation as? ImperativeMapPin {
            view.image = annotation.image
            view.centerOffset.y += 20
        }
    }

    func changePinTappedCar(view: MKAnnotationView?) {
        if let annotation = view?.annotation as? ImperativeMapPin {
            let image = annotation.transferable ? UIImage.pinBigGiveaway : UIImage.pinBigCar
            view?.image = image.resizePin(height: 50, width: 30)
        }
    }
}

// MARK: CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    // MARK: start map position -> user
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

    // MARK: rotate phone
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if let userAnnotationView = mapView.view(for: mapView.userLocation) as? UserAnnotationView {
            userAnnotationView.transform = CGAffineTransform(
                rotationAngle: newHeading.trueHeading * .pi / 180
            )
        }
    }
}
