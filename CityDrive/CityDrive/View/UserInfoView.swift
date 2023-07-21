//
//  UserInfoView.swift
//  CityDrive
//
//  Created by Иван Вдовин on 21.07.2023.
//

import SwiftUI

struct UserInfoView: View {
    @ObservedObject var settingVM: SettingViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Имя")
                    Spacer()
                    Text(settingVM.user?.firstName ?? "")
                }
                HStack {
                    Text("Фамилия")
                    Spacer()
                    Text(settingVM.user?.lastName ?? "")
                }
                HStack {
                    Text("Пол")
                    Spacer()
                    Text(settingVM.user?.gender ?? "")
                }
                HStack {
                    Text("Телефон")
                    Spacer()
                    Text(String(settingVM.user?.phone ?? 0))
                }
                HStack {
                    Text("Почта")
                    Spacer()
                    Text(settingVM.user?.email ?? "")
                }
            }
            
            Section {
                NavigationLink(destination: {
                    List {
                        Section {
                            HStack {
                                Text("Реферальный код")
                                Spacer()
                                Text(settingVM.user?.referralCode ?? "")
                                    .textSelection(.enabled)
                            }
                        }
                        HStack {
                            Text("user ID")
                            Spacer()
                            Text(settingVM.user?.userID ?? "")
                                .textSelection(.enabled)
                        }
                        HStack {
                            Text("")
                            Spacer()
                            Text(settingVM.user?.referralCode ?? "")
                        }
                        HStack {
                            Text("")
                            Spacer()
                            Text(settingVM.user?.referralCode ?? "")
                        }
                    }
                }) {
                    Text("Дополнительная информация")
                }
            }
            
            Button("Выйти") {
                settingVM.exit()
                dismiss()
            }
            .foregroundStyle(.red)
        }
    }
}

#Preview {
    UserInfoView(settingVM: SettingViewModel())
}
