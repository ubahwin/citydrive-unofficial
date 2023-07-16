//
//  AboutCarView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI

struct AboutCarView: View {
    var car: CarOrder?
    
    var body: some View {
        List {
            Section("Информация") {
                HStack {
                    Text("Модель")
                    Spacer()
                    Text(car?.model ?? "")
                }
                HStack {
                    Text("Номер")
                    Spacer()
                    Text(car?.number ?? "")
                }
                HStack {
                    Text("Значение одометра в начале поездки")
                    Spacer()
                    Text(String(car?.odometer.atStart ?? 0))
                }
                HStack {
                    Text("Значение одометра в конце поездки")
                    Spacer()
                    Text(String(car?.odometer.atFinish ?? 0))
                }
                HStack {
                    Text("ID")
                    Spacer()
                    Text(car?.id ?? "")
                        .textSelection(.enabled)
                }
            }
            Section("Картинка") {
                VStack {
                    AsyncImage(url: URL(string: car?.img ?? ""))
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

#Preview {
    AboutCarView(car: CarOrder(id: "ads", number: "ads", model: "asd", img: "qw", odometer: Odometer(atStart: 21, atFinish: 423)))
}
