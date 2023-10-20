import Foundation
import SwiftKeychainWrapper
import SwiftUI
import _MapKit_SwiftUI

class SettingViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var logged: Bool?
    @Published var user: User?
    @Published var selectedInteractions: [String] {
        didSet {
            UserDefaults.standard.set(selectedInteractions, forKey: "selectedInteractions")
        }
    }
    @State var interactions: [MapInteraction] = MapInteraction.allCases

    @AppStorage("isDarkTheme") var isDarkTheme = true
    @AppStorage("selectedCity") var сity: City = .spb
    @AppStorage("selectedMapType") var mapType: MapType = .standard

    init() {
        self.networkManager = NetworkManager()

        logged = UserDefaults.standard.bool(forKey: "isLogged")
        selectedInteractions = UserDefaults.standard.stringArray(forKey: "selectedInteractions") ?? []

        loadUser()
    }

    func exit() {
        withAnimation {
            logged = false
        }
        UserDefaults.standard.set(false, forKey: "isLogged")
        KeychainWrapper.standard.set("", forKey: "sessionID")
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
