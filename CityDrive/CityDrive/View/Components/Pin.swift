//
//  Pin.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import SwiftUI
import MapKit

struct Pin: View {
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
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
    Pin(color: .green)
}
