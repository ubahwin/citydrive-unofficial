//
//  CarView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 22.07.2023.
//

import SwiftUI
import MapKit

struct CarView: View {
    @Binding var car: MKMapItem?
    
    var body: some View {
<<<<<<< HEAD
        NavigationStack {
            HStack {
                Text(car?.name ?? "").font(.title) // model
                Spacer()
                Text(car?.accessibilityHint ?? "") // number
=======
        VStack {
            HStack {
                Text(car?.name ?? "").font(.title) // model
                Spacer()
                Text(car?.phoneNumber ?? "") // number
>>>>>>> origin/main
                    .padding(5)
                    .background(.gray)
                    .clipShape(.buttonBorder)
            }
            AsyncImage(url: car?.url) { image in // img
                image
            } placeholder: {
                Image(systemName: "car")
            }
<<<<<<< HEAD
            
            NavigationLink("Дополнительная информация", destination: {
                List {
                    HStack {
                        Text("distance")
                        Spacer()
                        Text(car?.placemark.title ?? "")
                    }
                }
            })
        }.padding()
=======
            List {
                HStack {
                    Text("distance")
                    Spacer()
                    Text(car?.placemark.accessibilityUserInputLabels?.first ?? "")
                }
//                HStack {
//                    Text("walktime")
//                    Spacer()
//                    Text(car?.placemark.accessibilityUserInputLabels?[1] ?? "")
//                }
//                HStack {
//                    Text("fuel")
//                    Spacer()
//                    Text(car?.placemark.accessibilityUserInputLabels?[2] ?? "")
//                }

            }
        }
        .padding()
>>>>>>> origin/main
    }
}

#Preview {
    CarView(car: .constant(nil))
}
