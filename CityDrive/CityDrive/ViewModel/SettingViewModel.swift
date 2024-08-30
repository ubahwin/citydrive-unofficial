import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var user: User?

    @AppStorage(Settings.isLogged) var isLogged: Bool = false
    @AppStorage(Settings.mapType) var mapType: MapType = .standard
    @AppStorage(Settings.city) var city: City = .moscow
    @AppStorage(Settings.isDarkMode) var isDarkMode: Bool = true
    @AppStorage(Settings.paybackPercent) var paybackPercent: Int = 20
    @AppStorage(Settings.isDriverDiscont) var isDriverDiscont = false

    init() {
        self.networkManager = NetworkManager()
        loadUser()
    }

    func exit() {
        withAnimation {
            self.isLogged = false
        }
        Settings.sessionID = ""
    }

    func loadUser() {
        networkManager.getUser { response, error in
            if let error = error {
                print(error) // TODO: logging
                return
            }

            if let userResponse: FullUserResponse = response {
                let user: User = userResponse.mapToUser()

                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
}
