//
//  OtherInfoView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 09.07.2023.
//

import SwiftUI

struct OtherInfoView: View {
    var otherInfo: OtherInfoOrder?
    
    var body: some View {
        List {
            HStack {
                Text("tariff mode")
                Spacer()
                Text(otherInfo?.tariffMode ?? "")
            }
            HStack {
                Text("tariff package")
                Spacer()
                Text(otherInfo?.tariffPackage ?? "")
            }
            HStack {
                Text("zone expansion")
                Spacer()
                Text(otherInfo?.zoneExpansion ?? "")
            }


        }
    }
}

#Preview {
    OtherInfoView()
}
