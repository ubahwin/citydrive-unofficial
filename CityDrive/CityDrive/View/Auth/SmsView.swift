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
    var networkManager: NetworkManager
    
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
                networkManager.sendSms(phone: phone, smsCode: Int(smsCode) ?? 0) { response, error in // TODO: replace to VM
                    if let success = response?.success {
                        isEntered = success
                        
                        UserDefaults.standard.set(success, forKey: "isLogged")
                        KeychainWrapper.standard.set(response?.sessionID ?? "", forKey: "sessionID") // token security
                    }
                }
                
            }
            .buttonStyle(GreenButton())
            .fullScreenCover(isPresented: $isEntered, content: { ContentView() })
            Spacer().frame(height: 50)
        }
    }
}

#Preview {
    SmsView(phone: "9803532589", networkManager: NetworkManager())
}
