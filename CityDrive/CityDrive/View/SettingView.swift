//
//  SettingView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import SwiftUI

struct SettingView: View {
    @State private var openLogin = false
    @State private var logged = false
    
    var name: String
    
    var body: some View {
        NavigationStack {
            List {
                Section("Авторизация") {
                    if logged {
                        HStack {
                            Text("Вы вошли под именем \(name)")
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    .foregroundColor(.red)
                            })
                        }
                    } else {
                        Button("Войти") {
                            openLogin = true
                        }
                    }
                }
            }
            .navigationTitle("Настройки")
        }
        .fullScreenCover(isPresented: $openLogin, content: { LoginView() })
    }
}

#Preview {
    SettingView(name: "asd")
}
