import SwiftUI

@main
struct CityDriveApp: App {
    @AppStorage(Settings.isLogged) private var isLogged: Bool = false
    @AppStorage(Settings.isDarkMode) private var isDarkMode: Bool = true

    var body: some Scene {
        WindowGroup {
            if !isLogged {
                LoginView()
            } else {
                ContentView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
    }
}
