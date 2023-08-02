//
//  LoginView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
            
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Text("+7")
                    TextField("", text: $loginVM.phone)
                        .keyboardType(.phonePad)
                        .frame(maxWidth: 220)
                    Spacer()
                }.font(.largeTitle)
                Spacer()
                Button("Дальше") {
                    loginVM.sendSmsToPhone()
                }
                .buttonStyle(GreenButton())
                Spacer().frame(height: 50)
            }
        }
        .onTapGesture {
            loginVM.hideKeyboard()
        }
        .fullScreenCover(isPresented: $loginVM.next, content: { SmsView(loginVM: loginVM) })
    }
}

#Preview {
    LoginView()
}
