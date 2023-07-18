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
                .frame(height: 10)
            Circle()
                .stroke(lineWidth: 2)
                .fill(.white)
                .frame(height: 10)
                .shadow(radius: 1)
        }
    }
}

#Preview {
    Pin(color: .green)
}
