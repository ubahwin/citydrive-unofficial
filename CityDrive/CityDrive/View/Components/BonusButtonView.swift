//
//  BonusButtonView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 18.07.2023.
//

import SwiftUI

struct BonusButtonView: View {
    @ObservedObject var mapVM: MapViewModel
    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        VStack {
            Button(
                action: {
                    // empty
                },
                label: {
                    HStack {
                        Text(mapVM.bonusBalance)
                        BonusImage()
                    }
                }
            )
            .padding(10)
            .background(colorScheme == .dark ? .black : .white)
            .foregroundStyle(colorScheme == .dark ? .green : .black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onAppear {
                mapVM.loadBonusBalance()
            }
        }
    }
}

#Preview {
    BonusButtonView(mapVM: MapViewModel())
}
