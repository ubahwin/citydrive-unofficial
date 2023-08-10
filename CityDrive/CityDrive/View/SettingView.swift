//
//  SettingView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 16.06.2023.
//

import SwiftUI
import MapKit

struct SettingView: View {
    @StateObject private var settingVM = SettingViewModel()

    @State private var openLogin = false
        
    var body: some View {
        NavigationStack {
            List {
                if settingVM.logged ?? false {
                    NavigationLink(destination: {
                        UserInfoView(settingVM: settingVM)
                    }) {
                        HStack {
                            AsyncImage(url: URL(string: settingVM.user?.avatar ?? "")) { image in
                                Avatar(image: image)
                            } placeholder: {
                                Avatar()
                            }
                            VStack(alignment: .leading) {
                                Text(settingVM.user?.firstName ?? "")
                                Text(settingVM.user?.lastName ?? "")
                            }
                            .redacted(reason: settingVM.user == nil ? .placeholder : [])
                            .bold()
                            .padding(5)
                            Spacer()
                        }
                        .allowsHitTesting(settingVM.user == nil)
                    }
                } else {
                    Button("Войти") {
                        openLogin = true
                    }
                }
                
                Section("Карта") {
                    Picker("Город", selection: settingVM.$сity) {
                        Text(City.SPb.title).tag(City.SPb)
                        Text(City.Moscow.title).tag(City.Moscow)
                        Text(City.Sochi.title).tag(City.Sochi)
                    }
                    Picker("Тип карты", selection: settingVM.$mapType) {
                        Text(MapType.standard.title).tag(MapType.standard)
                        Text(MapType.hybrid.title).tag(MapType.hybrid)
                    }
                    MapInteractions(settingVM: settingVM)
                }
                Toggle("Тёмная тема", isOn: settingVM.$isDarkTheme)
            }
            .navigationTitle("Настройки")
        }
        .fullScreenCover(isPresented: $openLogin, content: { LoginView() })
    }
}

#Preview {
    SettingView()
}
