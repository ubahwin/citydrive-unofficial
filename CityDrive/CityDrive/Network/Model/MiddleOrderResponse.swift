import Foundation

struct MiddleOrderResponse: Codable {
    let locationStart, locationFinish: LocationResponse?
    let details: MiddleDetailsResponse?

    enum CodingKeys: String, CodingKey {
        case locationStart = "location_start"
        case locationFinish = "location_finish"
        case details
    }
}

struct MiddleDetailsResponse: Codable {
    let title, description: String?
    let rows: [RowResponse]?
}

struct RowResponse: Codable {
    let rowLeft, rowRight: ColumnResponse?

    enum CodingKeys: String, CodingKey {
        case rowLeft = "left"
        case rowRight = "right"
    }
}

struct ColumnResponse: Codable {
    let text: String?
    let iconURL: String?
    let color, fontStyle: String?

    enum CodingKeys: String, CodingKey {
        case text
        case iconURL = "icon_url"
        case color
        case fontStyle = "font_style"
    }
}

struct LocationResponse: Codable {
    let timestamp, address: String?
    let lat, lon: Double?
}
