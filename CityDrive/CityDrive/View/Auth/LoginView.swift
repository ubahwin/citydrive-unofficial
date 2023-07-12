//
//  LoginView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var phone = ""
    @State private var next = false
        
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Text("+7")
                    TextField("", text: $phone)
                        .keyboardType(.phonePad)
                        .frame(maxWidth: 220)
                    Spacer()
                }.font(.largeTitle)
                Spacer()
                Button("Дальше") {
                    NetworkManager.shared.sendPhone(phone: phone) { response, error in
                        if let success = response?.success {
                            next = success
                        }
                    }
                }
                .buttonStyle(GreenButton())
                Spacer().frame(height: 50)
            }
        }
        .fullScreenCover(isPresented: $next, content: { SmsView(phone: phone) })
    }
}

#Preview {
    LoginView()
}
