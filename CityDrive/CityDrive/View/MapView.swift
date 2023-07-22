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
    @State var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ZStack {
            Map(position: $camera, interactionModes: mapVM.interactions) {
                ForEach(mapVM.cars) { car in
                    Annotation(car.model, coordinate: car.coordinate) {
                        Pin(color: .green)
                            .onTapGesture {
                                withAnimation {
                                    camera = .region(MKCoordinateRegion(center: car.coordinate, latitudinalMeters: 300, longitudinalMeters: 300))
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
                    VStack(alignment: .leading) {
                        BonusButtonView(mapVM: mapVM)
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
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .mapControls {
            MapCompass()
            MapPitchButton()
            MapUserLocationButton()
                .buttonBorderShape(.capsule)
        }
        .mapStyle(mapVM.mapType?.mapStyle ?? MapStyle.standard)
    }
}




#Preview {
    MapView()
}
