//
//  CarView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 22.07.2023.
//

import SwiftUI

struct CarView: View {
    var car: Car?
    
    var body: some View {
        VStack {
            HStack {
                Text(car?.model ?? "").bold()
                Spacer()
                Text(car?.number ?? "")
            }
            AsyncImage(url: URL(string: car?.img ?? "")) { image in
                image
            } placeholder: {
                Image(systemName: "car")
            }
        }.padding()
    }
}

#Preview {
    CarView()
}
