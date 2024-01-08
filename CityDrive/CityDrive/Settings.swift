import Foundation
import SwiftKeychainWrapper

struct Settings {
    static var isLogged = "isLogged"
    static var mapType = "mapType"
    static var city = "city"
    static var isDarkMode = "isDarkMode"
    static var paybackPercent = "paybackPercent"
    static var isDriverDiscont = "paybackPercent"
    static var spendingBonuses = "spendingBonuses"

    static var sessionID: String {
        get {
            return KeychainWrapper.standard.string(forKey: "sessionID") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "sessionID")
        }
    }

    static var greenArea: GreenArea? {
        get {
            if let savedData = UserDefaults.standard.data(forKey: "greenArea"),
               let greenArea = try? JSONDecoder().decode(GreenArea.self, from: savedData) {
                return greenArea
            }
            return nil
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: "greenArea")
            }
        }
    }

    static var selectedInteractions: [MapInteraction] {
        get {
            if let savedInteractions = UserDefaults.standard.value(forKey: "mapInteractions") as? [String] {
                return savedInteractions.compactMap { MapInteraction(rawValue: $0) }
            }
            return []
        }
        set {
            let interactionsToSave = newValue.map { $0.rawValue }
            UserDefaults.standard.set(interactionsToSave, forKey: "mapInteractions")
        }
    }
}
