import SwiftUI
import MapKit

struct SettingView: View {
    @ObservedObject var settingVM: SettingViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                List {
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
                    Section("Карта") {
                        Picker("Город", selection: settingVM.$city) {
                            Text(City.spb.title).tag(City.spb)
                            Text(City.moscow.title).tag(City.moscow)
                            Text(City.sochi.title).tag(City.sochi)
                        }
                        Picker("Тип карты", selection: settingVM.$mapType) {
                            Text(MapType.standard.title).tag(MapType.standard)
                            Text(MapType.hybrid.title).tag(MapType.hybrid)
                        }
                    }
                    Toggle("Тёмная тема", isOn: settingVM.$isDarkMode)
                }
            }
            .navigationTitle("Настройки")
        }
    }
}

#Preview {
    SettingView(settingVM: SettingViewModel())
}
