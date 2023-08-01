//
//  SmsView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct SmsView: View {
<<<<<<< Updated upstream
    @State private var smsCode = ""
    @State private var isEntered = false
    
    var phone: String
    var networkManager: NetworkManager
=======
    @ObservedObject var loginVM: LoginViewModel
>>>>>>> Stashed changes
    
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            TextField("******", text: $loginVM.smsCode)
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Spacer()
            Button("Войти") {
<<<<<<< Updated upstream
                networkManager.sendSms(phone: phone, smsCode: Int(smsCode) ?? 0) { response, error in // TODO: replace to VM
                    if let success = response?.success {
                        isEntered = success
                        UserDefaults.standard.set(success, forKey: "isLogged")
                        KeychainWrapper.standard.set(response?.sessionID ?? "", forKey: "sessionID") // token security
                    }
                }
            }
            .buttonStyle(GreenButton())
<<<<<<< HEAD
            .fullScreenCover(isPresented: $isEntered, content: { MapView() })
=======
                loginVM.enter()
            }
            .buttonStyle(GreenButton())
            .fullScreenCover(isPresented: $loginVM.isEntered, content: { ContentView() })
>>>>>>> Stashed changes
=======
            .fullScreenCover(isPresented: $isEntered, content: { ContentView() })
>>>>>>> origin/main
            Spacer().frame(height: 50)
        }
    }
}

#Preview {
    SmsView(loginVM: LoginViewModel())
}
