import Foundation

struct UserSettings {
    var isLogged: Bool

    var city: City
    var mapType: MapType
    var theme: Theme
    var mapInteractions: [MapInteraction]
}
