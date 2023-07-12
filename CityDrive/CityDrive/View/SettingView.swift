//
//  SettingView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var settingVM = SettingViewModel()

    @State private var openLogin = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Авторизация") {
                    if settingVM.logged {
                        HStack {
                            Text("Вы вошли как \(settingVM.username)")
                            Spacer()
                            Button(action: {
                                settingVM.exit()
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
    SettingView()
}
