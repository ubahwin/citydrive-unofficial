//
//  MapView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.07.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapVM = MapViewModel()
    
    @State private var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var region = ""
    @Namespace private var locationSpace
    
    var body: some View {
        Map(position: $camera, scope: locationSpace) {
            ForEach(mapVM.cars) { car in
                Annotation(car.model, coordinate: car.coordinate) {
                    Pin(color: .green)
                        .onTapGesture {
                            withAnimation {
                                camera = .region(MKCoordinateRegion(center: car.coordinate, latitudinalMeters: 100, longitudinalMeters: 100))
                            }
                        }
                }
            }
            UserAnnotation() {
                Pin(color: .blue)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            VStack {
                MapUserLocationButton(scope: locationSpace)
                    .buttonBorderShape(.capsule)
            }
            .padding()
        }
        .mapScope(locationSpace)
        .mapStyle(mapVM.mapStyle)
    }
}
#Preview {
    MapView()
}
