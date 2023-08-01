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
<<<<<<< HEAD
        
=======
    
>>>>>>> origin/main
    @State var carSelected: MKMapItem?
    @State var openCarDetail = false
    
    var body: some View {
        ZStack {
            Map(position: $camera, interactionModes: mapVM.interactions, selection: $carSelected, scope: scope) {
                ForEach(mapVM.cars, id: \.self) { car in
<<<<<<< HEAD
                    Annotation(car.placemark.name ?? "", coordinate: car.placemark.coordinate) {
                        Pin(color: .green)
                    }
=======
                    
                    Annotation(car.placemark.name ?? "", coordinate: car.placemark.coordinate) {
                        Pin(color: .green)
//                            .onTapGesture {
//                                withAnimation {
//                                    openCarDetail = true
//                                    camera = .region(MKCoordinateRegion(center: car.placemark.coordinate, latitudinalMeters: 300, longitudinalMeters: 300))
//                                }
//                            }
                    }

>>>>>>> origin/main
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
<<<<<<< HEAD
        .onChange(of: carSelected) { old, new in
            withAnimation {
                openCarDetail = new != nil
                if let coordinate = carSelected?.placemark.coordinate {
                    camera = .region(MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200))
                }
            }
        }
        .sheet(isPresented: $openCarDetail) {
            CarView(car: $carSelected)
                .presentationDetents([.height(260)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(260)))
                .presentationCornerRadius(10)
=======
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
>>>>>>> origin/main
        }
    }
}

<<<<<<< HEAD
=======



>>>>>>> origin/main
#Preview {
    MapView()
}
