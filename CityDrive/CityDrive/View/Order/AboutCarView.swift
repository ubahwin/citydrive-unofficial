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
                SimpleCellView(name: "Модель", value: car?.model)
                SimpleCellView(name: "Номер", value: car?.number)
                SimpleCellView(name: "ID", value: car?.id).textSelection(.enabled)
            }
            Section("Значения одометра") {
                SimpleCellView(name: "В начале", value: car?.odometer.atStart)
                SimpleCellView(name: "В конце", value: car?.odometer.atFinish)
            }
            Section("Фотокарточка") {
                AsyncImage(url: URL(string: car?.img ?? "")) { image in // img
                    image
                } placeholder: {
                    Image(systemName: "car")
                }
            }
        }
    }
}

#Preview {
    AboutCarView(
        car: CarOrder(
            id: "ads",
            number: "ads",
            model: "asd",
            img: "qw",
            odometer: Odometer(atStart: 21, atFinish: 423)
        )
    )
}
