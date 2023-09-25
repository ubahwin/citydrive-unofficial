//
//  CarView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 22.07.2023.
//

import SwiftUI
import MapKit

struct CarView: View {
    @Binding var car: MKMapItem?

    var body: some View {
        NavigationStack {
            HStack {
                Text(car?.name ?? "").font(.title) // model
                Spacer()
                Text(car?.accessibilityHint ?? "") // number
                    .padding(5)
                    .background(.gray)
                    .clipShape(.buttonBorder)
            }
            AsyncImage(url: car?.url) { image in // img
                image
            } placeholder: {
                Image(systemName: "car")
            }
        }
        .padding()
    }
}

#Preview {
    CarView(car: .constant(nil))
}
