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
    
    @State private var region: MapCameraPosition = .region(.myRegion)
    
    var body: some View {
        List {
            Section("Откуда") {
                VStack(alignment: .leading) {
                    HStack {
                        Text(path?.period.start.ISO8601ToDate() ?? Date(), style: .date)
                        Text(path?.period.start.ISO8601ToDate() ?? Date(), style: .time)
                    }
                    Spacer()
                    NavigationLink(destination: {
                        Map {
                            Annotation("", coordinate: CLLocationCoordinate2D(
                                latitude: path?.start.lat ?? 0,
                                longitude: path?.start.lon ?? 0), content: { Pin(color: .green) })
                        }
                    }) {
                        HStack {
                            Pin(color: .green)
                            Spacer()
                            Text("Санкт-Петербург, Нарвская, д. 5")
                            Spacer()
                        }
                    }
                    .padding()
                    .bold()
                    
                }
                .padding()
            }
            
            Section("Куда") {
                VStack(alignment: .leading) {
                    HStack {
                        Text(path?.period.finish.ISO8601ToDate() ?? Date(), style: .date)
                        Text(path?.period.finish.ISO8601ToDate() ?? Date(), style: .time)
                    }
                    Spacer()
                    NavigationLink(destination: {
                        Map {
                            Annotation("", coordinate: CLLocationCoordinate2D(
                                latitude: path?.finish.lat ?? 0,
                                longitude: path?.finish.lon ?? 0), content: { Pin(color: .purple) })
                        }
                    }) {
                        HStack {
                            Pin(color: .purple)
                            Spacer()
                            Text("Санкт-Петербург, Нарвская, д. 5")
                            Spacer()
                        }
                    }
                    .padding()
                    .bold()
                    
                }
                .padding()
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: 59.901153, longitude: 30.274750)
    }
}
extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}

#Preview {
    AboutPathView(path: PathOrder(
        start: LocateOrder(lat: 59.901153, lon: 30.274750),
        finish: LocateOrder(lat: 59.902153, lon: 30.214750),
        period: PeriodOrder(start: "2023-07-06T09:01:25.574Z", finish: "2023-07-06T09:04:30.574Z"))
    )
}
