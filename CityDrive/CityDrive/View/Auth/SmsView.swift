//
//  SmsView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct SmsView: View {
    @State private var smsCode = ""
    @State private var isEntered = false
    
    var phone: String
    
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            TextField("******", text: $smsCode)
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Spacer()
            Button("Войти") {
                NetworkManager.shared.sendSms(phone: phone, smsCode: Int(smsCode) ?? 0) { response, error in // TODO: replace to VM
                    if let success = response?.success {
                        isEntered = success
                    }
                }
            }
            .buttonStyle(GreenButton())
            .fullScreenCover(isPresented: $isEntered, content: { MapView(mapVM: MapViewModel()) })
            Spacer().frame(height: 50)
        }
    }
}

#Preview {
    SmsView(phone: "9803532589")
}
