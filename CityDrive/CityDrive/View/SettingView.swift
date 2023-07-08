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
                Section("authorization") {
                    if settingVM.logged {
                        HStack {
                            Text("loginAs \(settingVM.username)")
                            Spacer()
                            Button(action: {
                                settingVM.logged = false
                            }, label: {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    .foregroundColor(.red)
                            })
                        }
                    } else {
                        Button("login") {
                            openLogin = true
                        }
                    }
                }
                #if DEBUG 
                Section("For test") {
                    Toggle("logged", isOn: $settingVM.logged)
                }
                #endif
            }
            .navigationTitle("settings")
        }
        .fullScreenCover(isPresented: $openLogin, content: { LoginView() })
    }
}

#Preview {
    SettingView()
}
