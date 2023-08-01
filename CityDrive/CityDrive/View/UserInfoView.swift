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
<<<<<<< HEAD
                SimpleCellView(name: "Имя", value: settingVM.user?.firstName)
                SimpleCellView(name: "Фамилия", value: settingVM.user?.lastName)
                SimpleCellView(name: "Пол", value: settingVM.user?.gender.title)
                SimpleCellView(name: "Телефон", value: settingVM.user?.phone)
                SimpleCellView(name: "Почта", value: settingVM.user?.email)
=======
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
                    Text(settingVM.user?.gender.title ?? "")
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
>>>>>>> origin/main
            }
            
            Section {
                NavigationLink(destination: {
                    List {
                        Section {
<<<<<<< HEAD
                            SimpleCellView(name: "Реферальный код", value: settingVM.user?.referralCode).textSelection(.enabled)
                            SimpleCellView(name: "Привзанная карта", value: settingVM.user?.card.number)
                            SimpleCellView(name: "Баланс", value: settingVM.user?.debt)
                        }
                        
                        Section {
                            SimpleCellView(name: "bonus", value: settingVM.user?.bonus)
                            SimpleCellView(name: "is risk profile enabled", value: settingVM.user?.isRiskProfileEnabled)
                            SimpleCellView(name: "user ID", value: settingVM.user?.userID)
                            SimpleCellView(name: "user corporate role ID", value: settingVM.user?.userCorporateRoleID)
                            SimpleCellView(name: "subscriptionStatus", value: settingVM.user?.subscriptionStatus)
                            SimpleCellView(name: "send push", value: settingVM.user?.sendPush)
                            SimpleCellView(name: "level", value: settingVM.user?.level)
                            SimpleCellView(name: "rating", value: settingVM.user?.rating)
                        }
                        
                        Section("ratingV2") {
                            SimpleCellView(name: "level", value: settingVM.user?.ratingV2.level)
=======
                            HStack {
                                Text("Реферальный код")
                                Spacer()
                                Text(settingVM.user?.referralCode ?? "")
                                    .textSelection(.enabled)
                            }
                        }
                        Section {
                            HStack {
                                Text("Привзанная карта")
                                Spacer()
                                Text(settingVM.user?.card.number ?? "")
                                    .textSelection(.enabled)
                            }
                        }
                        
                        HStack {
                            Text("bonus")
                            Spacer()
                            Text(settingVM.user?.bonus.description ?? "")
                        }
                        HStack {
                            Text("debt")
                            Spacer()
                            Text(settingVM.user?.debt.description ?? "")
                        }
                        HStack {
                            Text("is risk profile enabled")
                            Spacer()
                            Text(settingVM.user?.isRiskProfileEnabled.description ?? "")
                        }
                        HStack {
                            Text("user ID")
                            Spacer()
                            Text(settingVM.user?.userID ?? "")
                                .textSelection(.enabled)
                        }
                        HStack {
                            Text("user corporate role ID")
                            Spacer()
                            Text(settingVM.user?.userCorporateRoleID ?? "")
                        }
                        HStack {
                            Text("subscription status")
                            Spacer()
                            Text(settingVM.user?.subscriptionStatus ?? "")
                        }
                        HStack {
                            Text("send push")
                            Spacer()
                            Text(settingVM.user?.sendPush.description ?? "")
                        }
                        HStack {
                            Text("level")
                            Spacer()
                            Text(settingVM.user?.level.description ?? "")
                        }
                        HStack {
                            Text("level")
                            Spacer()
                            Text(settingVM.user?.rating.description ?? "")
                        }
                        
                        Section("ratingV2") {
                            HStack {
                                Text("level")
                                Spacer()
                                Text(settingVM.user?.ratingV2.level.description ?? "")
                            }
>>>>>>> origin/main
                            HStack {
                                Text("levelX0UpdatedAt")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelX0UpdatedAt.ISO8601ToDate() ?? Date(), style: .date)
                            }
<<<<<<< HEAD
                            SimpleCellView(name: "rating", value: settingVM.user?.ratingV2.rating)
                            SimpleCellView(name: "ratingV2Level", value: settingVM.user?.ratingV2.ratingV2Level)
                            SimpleCellView(name: "days of levelNext", value: settingVM.user?.ratingV2.levelNext.days)
                            SimpleCellView(name: "levelNextNumber of levelNext", value: settingVM.user?.ratingV2.levelNext.levelNextNumber)
                            SimpleCellView(name: "number of levelNext", value: settingVM.user?.ratingV2.levelNext.number)
                            SimpleCellView(name: "rating of levelNext", value: settingVM.user?.ratingV2.levelNext.rating)
                            SimpleCellView(name: "trips of levelNext", value: settingVM.user?.ratingV2.levelNext.trips)
                        }
                        
=======
                            HStack {
                                Text("rating")
                                Spacer()
                                Text(settingVM.user?.ratingV2.rating.description ?? "")
                            }
                            HStack {
                                Text("ratingV2Level")
                                Spacer()
                                Text(settingVM.user?.ratingV2.ratingV2Level.description ?? "")
                            }
                            HStack {
                                Text("days of levelNext")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelNext.days.description ?? "")
                            }
                            HStack {
                                Text("levelNextNumber of levelNext")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelNext.levelNextNumber.description ?? "")
                            }
                            HStack {
                                Text("number of levelNext")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelNext.number.description ?? "")
                            }
                            HStack {
                                Text("rating of levelNext")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelNext.rating.description ?? "")
                            }
                            HStack {
                                Text("trips of levelNext")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelNext.trips.description ?? "")
                            }
                        }
>>>>>>> origin/main
                        Section("achievements") {
                            ForEach(settingVM.user?.ratingV2.achievements ?? []) { achievement in
                                Text(achievement.localeName)
                            }
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
