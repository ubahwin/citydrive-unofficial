import Foundation

struct Settings {
    static let isLogged = "isLogged"
    static let mapType = "mapType"
    static let city = "city"
    static let isDarkMode = "isDarkMode"
    static let paybackPercent = "paybackPercent"
    static let isDriverDiscont = "paybackPercent"
    static let spendingBonuses = "spendingBonuses"
    static let enableFeedbackGenerator = "enableFeedbackGenerator"

    static var sessionID: String {
        get {
            KeychainManager.shared.getToken(forKey: "sessionID") ?? ""
        }
        set {
            try? KeychainManager.shared.saveToken(newValue, forKey: "sessionID")
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
