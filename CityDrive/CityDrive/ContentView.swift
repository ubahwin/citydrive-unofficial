import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var mapVM = MapViewModel()
    @StateObject private var orderVM = OrdersViewModel()
    @StateObject private var settingVM = SettingViewModel()

    var body: some View {
        if mapVM.mapIsLoad {
            TabView {
                Group {
                    MapView(mapVM: mapVM)
                        .tabItem {
                            Image(systemName: "map")
                            Text("Карта")
                        }
                    OrderListView(orderVM: orderVM)
                        .tabItem {
                            Image(systemName: "list.bullet.clipboard")
                            Text("История поездок")
                        }
                    SettingView(settingVM: settingVM)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Настройки")
                        }
                }
                .toolbarBackground(.visible, for: .tabBar)
            }
            .accentColor(AppColor.green())
        } else {
            LoadingAppView()
        }
    }
}

#Preview {
    ContentView()
}
