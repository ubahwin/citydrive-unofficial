//
//  Pin.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import SwiftUI
import MapKit

struct Pin: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.green)
                .frame(height: 15)
            Circle()
                .stroke(lineWidth: 3)
                .fill(.white)
                .frame(height: 16)
                .shadow(radius: 3)
        }
    }
}

#Preview {
    Pin()
}
