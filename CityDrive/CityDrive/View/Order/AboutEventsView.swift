//
//  AboutEventsView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.07.2023.
//

import SwiftUI

struct AboutEventsView: View {
    var events: [EventOrder]?
    
    var body: some View {
        List {
            ForEach(events ?? []) { event in
                Section {
                    HStack {
                        Spacer()
                        Text(event.name)
                        Spacer()
                    }.padding()
                    
                    HStack {
                        Text("Начало")
                        Spacer()
                        Text(event.time.ISO8601ToDate() ?? Date(), style: .date)
                        Text(event.time.ISO8601ToDate() ?? Date(), style: .time)
                    }
                    SimpleCellView(name: "Продолжительность", value: String(event.duration.roundedToTwoDecimalPlaces()) + " сек.")
                    if event.state != "parking" {
                        LocationCellView(
                            locationName: event.name,
                            locationLatitude: event.lat,
                            locationLongitude: event.lon,
                            pinColor: .blue)
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    AboutEventsView(events: [
        EventOrder(
            id: UUID(),
            state: "booking",
            name: "bron",
            status: "done",
            time: "2023-07-06T05:31:46.410Z",
            cost: 0,
            duration: 1200,
            lat: 59.89942,
            lon: 30.274256,
            userLat: 59.89941574386331,
            userLon: 30.27413856715478),
        EventOrder(
            id: UUID(),
            state: "wait",
            name: "aasdasds",
            status: "done",
            time: "2023-07-06T08:31:46.410Z",
            cost: 0,
            duration: 1200,
            lat: 59.81952,
            lon: 30.274296,
            userLat: 59.89941574386331,
            userLon: 30.27413856715478)
    ])
}
