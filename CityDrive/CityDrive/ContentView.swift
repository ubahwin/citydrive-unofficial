import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                MapView()
                    .ignoresSafeArea()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Карта")
                    }
                OrderListView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                        Text("История поездок")
                    }
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Настройки")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
        .accentColor(.green)
    }
}

#Preview {
    ContentView()
}
