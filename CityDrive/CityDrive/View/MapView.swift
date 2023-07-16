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
    
    @Namespace private var locationSpace
    
    var body: some View {
        Map(scope: locationSpace) {
            ForEach(mapVM.cars) { car in
                Annotation(car.name, coordinate: car.coordinate) {
                    Pin(color: .green)
                }
            }
            UserAnnotation(content: { Pin(color: .blue).font(.system(size: 10)) })
        }
        .mapControls {
            MapCompass()
            MapPitchButton()
        }
        
        .overlay(alignment: .bottomTrailing) {
            MapUserLocationButton(scope: locationSpace)
                .buttonBorderShape(.capsule)
                .padding()
        }
        .mapScope(locationSpace)
    }
}

#Preview {
    MapView()
}
