//
//  LocationCellView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.07.2023.
//

import SwiftUI
import MapKit

struct LocationCellView: View {
    var interactionName: String
    var locationLatitude: Double
    var locationLongitude: Double
    var pinColor: Color
        
    @State private var address = ""
    
    var body: some View {
        NavigationLink(destination: {
            Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationLatitude, longitude: locationLongitude), latitudinalMeters: 300, longitudinalMeters: 300))) {
                Annotation(
                    interactionName,
                    coordinate: CLLocationCoordinate2D(
                        latitude: locationLatitude,
                        longitude: locationLongitude),
                    content: {
                        Pin(color: pinColor)
                    }
                )
            }
        }) {
            HStack {
                Pin(color: pinColor)
                Spacer()
                Text(address)
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: locationLatitude, longitude: locationLongitude)) { (placemarks, error) in
                if let error = error {
                    print("Ошибка геокодирования для начальной точки: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    let thoroughfare = placemark.thoroughfare ?? ""
                    let locality = placemark.locality ?? ""
                    
                    self.address = thoroughfare + ", " + locality
                }
            }
        }
    }
}

#Preview {
    LocationCellView(interactionName: "albatras", locationLatitude: 41.22135245345, locationLongitude: 67.984565, pinColor: .red)
}
