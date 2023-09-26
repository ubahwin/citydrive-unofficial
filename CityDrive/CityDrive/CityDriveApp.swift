import SwiftUI

@main
struct CityDriveApp: App {
    private var isLogged = UserDefaults.standard.bool(forKey: "isLogged")
    @AppStorage("isDarkTheme") var isDarkTheme: Bool?

    var body: some Scene {
        WindowGroup {
            if !isLogged {
                LoginView()
            } else {
                ContentView()
                    .preferredColorScheme(isDarkTheme ?? true ? .dark : .light)
            }
        }
    }
}
