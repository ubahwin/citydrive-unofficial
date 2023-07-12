//
//  PathView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI
import MapKit

struct PathView: View {
    var path: Path?
    var period: Period?
    
    var body: some View {
        List {
            VStack {
                Text("Откуда")
                HStack {
                    Text(StringConverter.ISO8601ToDate(period?.start ?? ""), style: .date)
                    Spacer()
//                    Map {
//                        Marker(coordinate: CLLocationCoordinate2D(
//                            latitude: <#T##CLLocationDegrees#>,
//                            longitude: <#T##CLLocationDegrees#>)) {
//                            Pin()
//                        }
//                    }
                }
                .padding()
            }
            VStack {
                Text("Куда")
                HStack {
                    Text(StringConverter.ISO8601ToDate(period?.finish ?? ""), style: .date)
                    Spacer()
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    PathView(path: Path(start: Finish(lat: 59.901153, lon: 30.274750), finish: Finish(lat: 59.902153, lon: 30.214750)), period: Period(start: "2023-07-06T09:01:25.574Z", finish: "2023-07-06T09:01:25.574Z"))
}
