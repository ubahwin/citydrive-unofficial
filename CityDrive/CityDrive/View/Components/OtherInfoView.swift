//
//  OtherInfoView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI

struct OtherInfoView: View {
    var noname: NNOrder?
    
    var body: some View {
        List {
            HStack {
                Text("tariff mode")
                Spacer()
                Text(noname?.tariffMode ?? "")
            }
            HStack {
                Text("tariff package")
                Spacer()
                Text(noname?.tariffPackage ?? "")
            }
            HStack {
                Text("zone expansion")
                Spacer()
                Text(noname?.zoneExpansion ?? "")
            }


        }
    }
}

#Preview {
    OtherInfoView()
}
