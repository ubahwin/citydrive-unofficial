import Foundation
import SwiftKeychainWrapper

struct Settings {
    static var isLogged = "isLogged"
    static var mapType = "mapType"
    static var city = "city"
    static var isDarkMode = "isDarkMode"

    static var sessionID: String {
        get {
            return KeychainWrapper.standard.string(forKey: "sessionID") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "sessionID")
        }
    }
}
