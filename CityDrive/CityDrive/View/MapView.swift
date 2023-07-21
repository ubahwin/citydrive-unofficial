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
    @Environment(\.colorScheme) var colorScheme
    @State private var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @Namespace private var locationSpace
    
    var body: some View {
        ZStack {
            Map(position: $camera, interactionModes: mapVM.interactions, scope: locationSpace) {
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
            
            VStack {
                HStack {
                    Button(
                        action: {
                            mapVM.loadCarStatus()
                        },
                        label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    )
                    .padding(10)
                    .background(colorScheme == .dark ? Color(hex: 0x212a2e) : .white)
                    .foregroundStyle(colorScheme == .dark ? .green : .black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer()
                    BonusButtonView(mapVM: mapVM)
                }
                Spacer()
                HStack {
                    Spacer()
                    MapUserLocationButton(scope: locationSpace)
                        .buttonBorderShape(.capsule)
                }
            }
            .padding()
        }
        .mapScope(locationSpace)
        .mapStyle(mapVM.mapType?.mapStyle ?? MapStyle.standard)
    }
}
#Preview {
    MapView()
}
