//
//  LocationCellView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.07.2023.
//

import SwiftUI
import MapKit

struct LocationCellView: View {
    var locationName: String
    var locationLatitude: Double
    var locationLongitude: Double
    var pinColor: Color
    
    @State private var address = ""
    
    var body: some View {
        NavigationLink(destination: {
            Map {
                Annotation(
                    locationName,
                    coordinate: CLLocationCoordinate2D(
                        latitude: locationLatitude,
                        longitude: locationLongitude),
                    content: {
                        Pin(color: pinColor)
                    })
            }
        }) {
            HStack {
                Pin(color: pinColor)
                Spacer()
                Text(address)
            }
        }
        .onAppear {
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(CLLocation(latitude: locationLatitude, longitude: locationLongitude)) { (placemarks, error) in
                if let error = error {
                    print("Ошибка геокодирования для начальной точки: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    let address = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
                    self.address = address
                }
            }
        }
    }
}

#Preview {
    LocationCellView(locationName: "albatras", locationLatitude: 41.22135245345, locationLongitude: 67.984565, pinColor: .red)
}
