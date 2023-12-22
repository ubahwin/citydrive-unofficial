import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var mapVM = MapViewModel()
    @StateObject private var orderVM = OrdersViewModel()
    @StateObject private var settingVM = SettingViewModel()

    @State var selectedTab: Tab = .map
    enum Tab: Hashable {
        case map, orderList, settings
    }

    var body: some View {
        if mapVM.mapIsLoad {
            TabView {
                Group {
                    MapView(mapVM: mapVM)
                        .tabItem {
                            Image(systemName: "map")
                            Text("Карта")
                        }
                        .tag(Tab.map)
                    OrderListView(orderVM: orderVM)
                        .tabItem {
                            Image(systemName: "list.bullet.clipboard")
                            Text("История поездок")
                        }
                        .tag(Tab.orderList)
                    SettingView(settingVM: settingVM)
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Настройки")
                        }
                        .tag(Tab.settings)
                }
                .toolbarBackground(.visible, for: .tabBar)
            }
            .onTapGesture(count: 2) {
                switch selectedTab {
                case .map:
                    mapVM.goToUser.toggle()
                case .orderList:
                    print("orderList")
                case .settings:
                    print("settings")
                }
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
