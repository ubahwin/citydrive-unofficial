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
    @State var openCarDetail = false
    
    var body: some View {
        ZStack {
            Map(position: $camera, interactionModes: mapVM.interactions, selection: $carSelected, scope: scope) {
                ForEach(mapVM.cars, id: \.self) { car in
                    
                    Annotation(car.placemark.name ?? "", coordinate: car.placemark.coordinate) {
                        Pin(color: .green)
//                            .onTapGesture {
//                                withAnimation {
//                                    openCarDetail = true
//                                    camera = .region(MKCoordinateRegion(center: car.placemark.coordinate, latitudinalMeters: 300, longitudinalMeters: 300))
//                                }
//                            }
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
        .onChange(of: carSelected, { old, new in
            withAnimation {
                openCarDetail = new != nil
                if let coordinate = carSelected?.placemark.coordinate {
                    camera = .region(MKCoordinateRegion(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300))
                }
            }
        })
        .sheet(isPresented: $openCarDetail) {
            CarView(car: $carSelected)
                .presentationDetents([.height(250)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(250)))
        }
    }
}




#Preview {
    MapView()
}
