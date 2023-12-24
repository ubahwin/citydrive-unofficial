import Foundation

struct MapCityResponse: Codable {
    let lat, lon: Double?
    let imgURL: String?

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case imgURL = "img_url"
    }
}

typealias MapCitiesResponse = [MapCityResponse]
