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
                VStack {
                    Text(event.state)
                    Text(event.name)
                    Text(event.status)
                    Text(event.time.ISO8601ToDate() ?? Date(), style: .time)
                    Text(String(event.lat))
                    Text(String(event.lon))
                    Text(String(event.cost))
                    Text(String(event.duration))
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
            userLon: 30.27413856715478)
    ])
}
