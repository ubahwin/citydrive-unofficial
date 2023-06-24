//
//  MyLocationView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import SwiftUI

struct MyLocationButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 50, height: 50)
                .shadow(radius: 3)
            Image(systemName: "location.fill")
                .imageScale(.large)
                .colorMultiply(.black)
        }
    }
}

#Preview {
    MyLocationButton()
}
