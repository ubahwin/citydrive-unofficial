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
    @Namespace var scope
    @State var carSelected: MKMapItem?
    
    var body: some View {
        ZStack {
            Map(position: $camera, interactionModes: mapVM.interactions, selection: $carSelected, scope: scope) {
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
                    HStack {
                        BonusButtonView(mapVM: mapVM)
                        RefreshMapButtonView(mapVM: mapVM)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    MapUserLocationButton(scope: scope)
                        .buttonBorderShape(.capsule)
                }
            }
            .padding()
        }
        .mapStyle(mapVM.mapType?.mapStyle ?? MapStyle.standard)
        .mapScope(scope)
    }
}




#Preview {
    MapView()
}
