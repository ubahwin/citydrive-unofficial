//
//  SmsView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI
import SwiftKeychainWrapper

struct SmsView: View {
    @State private var smsCode = ""
    @State private var isEntered = false
            
    var phone: String
    
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            TextField("smsCode", text: $smsCode)
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Spacer()
            Button("login") {
                NetworkManager.shared.sendSms(phone: phone, smsCode: Int(smsCode) ?? 0) { response, error in // TODO: replace to VM
                    if let success = response?.success {                        
                        isEntered = success
                        
                        UserDefaults.standard.set(response?.user.firstName ?? "", forKey: "username")
                        KeychainWrapper.standard.set(response?.sessionID ?? "", forKey: "sessionID") // token security
                    }
                }
                
            }
            .buttonStyle(GreenButton())
            .fullScreenCover(isPresented: $isEntered, content: { MapView() })
            Spacer().frame(height: 50)
        }
    }
}

#Preview {
    SmsView(phone: "9803532589")
}
