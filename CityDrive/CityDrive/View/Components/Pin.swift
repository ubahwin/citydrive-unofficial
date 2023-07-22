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
        Circle()
            .fill(color)
            .stroke(Color.white, lineWidth: 2)
            .frame(height: 10)
            .shadow(radius: 1)
    }
}

#Preview {
    Pin(color: .green)
}
