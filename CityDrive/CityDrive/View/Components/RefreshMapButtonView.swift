//
//  RefreshMapButtonView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 22.07.2023.
//

import SwiftUI

struct RefreshMapButtonView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(
            action: {
                withAnimation {
                    mapVM.carsIsLoaded = false
                    mapVM.loadCarStatus()
                }
            },
            label: {
                if mapVM.carsIsLoaded {
                    Image(systemName: "arrow.clockwise")
                        .frame(width: 20, height: 20)
                } else {
                    ProgressView()
                        .frame(width: 20, height: 20)
                }
            }
        )
        .padding(10)
        .background(colorScheme == .dark ? .black : .white)
        .foregroundStyle(colorScheme == .dark ? .green : .black)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    RefreshMapButtonView(mapVM: MapViewModel())
}
