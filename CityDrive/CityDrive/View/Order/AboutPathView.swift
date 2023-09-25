//
//  AboutPathView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI
import MapKit

struct AboutPathView: View {
    var path: PathOrder?

    var body: some View {
        NavigationStack {
            List {
                Section("Откуда") {
                    HStack {
                        Text(path?.period.start.ISO8601ToDate() ?? Date(), style: .date)
                        Text(path?.period.start.ISO8601ToDate() ?? Date(), style: .time)
                    }
                    LocationCellView(
                        interactionName: "",
                        locationLatitude: path?.start.lat ?? 0,
                        locationLongitude: path?.start.lon ?? 0,
                        pinColor: .green)
                    .padding()
                    .bold()
                }

                Section("Куда") {
                    HStack {
                        Text(path?.period.finish.ISO8601ToDate() ?? Date(), style: .date)
                        Text(path?.period.finish.ISO8601ToDate() ?? Date(), style: .time)
                    }
                    LocationCellView(
                        interactionName: "",
                        locationLatitude: path?.finish.lat ?? 0,
                        locationLongitude: path?.finish.lon ?? 0,
                        pinColor: .purple)
                    .padding()
                    .bold()
                }
            }
        }
        .navigationTitle("Путь")
    }
}

#Preview {
    AboutPathView(path: PathOrder(
        start: LocateOrder(lat: 59.901153, lon: 30.274750),
        finish: LocateOrder(lat: 59.902153, lon: 30.214750),
        period: PeriodOrder(start: "2023-07-06T09:01:25.574Z", finish: "2023-07-06T09:04:30.574Z"))
    )
}
