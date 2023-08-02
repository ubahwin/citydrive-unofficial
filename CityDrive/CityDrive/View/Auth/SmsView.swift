//
//  SmsView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import SwiftUI

struct SmsView: View {
    @ObservedObject var loginVM: LoginViewModel
    
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
                loginVM.enter()
            }
            .buttonStyle(GreenButton())
            .fullScreenCover(isPresented: $loginVM.isEntered, content: { ContentView() })
            Spacer().frame(height: 50)
        }
    }
}

#Preview {
    SmsView(loginVM: LoginViewModel())
}
