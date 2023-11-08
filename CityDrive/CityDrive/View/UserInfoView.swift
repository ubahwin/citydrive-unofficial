import SwiftUI

struct UserInfoView: View {
    @ObservedObject var settingVM: SettingViewModel

    @State private var openLogin = false

    var body: some View {
        List {
            Section {
                SimpleCellView(name: "Имя", value: settingVM.user?.firstName)
                SimpleCellView(name: "Фамилия", value: settingVM.user?.lastName)
                SimpleCellView(name: "Пол", value: settingVM.user?.gender.title)
                SimpleCellView(name: "Телефон", value: settingVM.user?.phone)
                SimpleCellView(name: "Почта", value: settingVM.user?.email)
            }

            Section {
                NavigationLink(destination: {
                    List {
                        Section {
                            SimpleCellView(
                                name: "Реферальный код",
                                value: settingVM.user?.referralCode
                            )
                            .textSelection(.enabled)
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
                            HStack {
                                Text("levelX0UpdatedAt")
                                Spacer()
                                Text(settingVM.user?.ratingV2.levelX0UpdatedAt.ISO8601ToDate() ?? Date(), style: .date)
                            }
                            SimpleCellView(
                                name: "rating",
                                value: settingVM.user?.ratingV2.rating
                            )
                            SimpleCellView(
                                name: "ratingV2Level",
                                value: settingVM.user?.ratingV2.ratingV2Level
                            )
                            SimpleCellView(
                                name: "days of levelNext", value: settingVM.user?.ratingV2.levelNext.days
                            )
                            SimpleCellView(
                                name: "levelNextNumber of levelNext",
                                value: settingVM.user?.ratingV2.levelNext.levelNextNumber
                            )
                            SimpleCellView(
                                name: "number of levelNext",
                                value: settingVM.user?.ratingV2.levelNext.number
                            )
                            SimpleCellView(
                                name: "rating of levelNext",
                                value: settingVM.user?.ratingV2.levelNext.rating
                            )
                            SimpleCellView(
                                name: "trips of levelNext",
                                value: settingVM.user?.ratingV2.levelNext.trips
                            )
                        }
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
                openLogin = true
            }
            .foregroundStyle(.red)
        }
        .fullScreenCover(isPresented: $openLogin) { LoginView() }
    }
}

#Preview {
    UserInfoView(settingVM: SettingViewModel())
}
