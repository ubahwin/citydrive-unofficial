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
    
    var name: String = "Тван"
    
    var body: some View {
        NavigationStack {
            List {
                Section("authorization") {
                    if logged {
                        HStack {
                            Text("loginAs \(name)")
                            Spacer()
                            Button(action: {
                                
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
            }
            .navigationTitle("setting")
        }
        .fullScreenCover(isPresented: $openLogin, content: { LoginView() })
    }
}

#Preview {
    SettingView()
}
