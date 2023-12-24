import Foundation

struct CarTariffResponse: Codable {
    let tariff: TariffResponse?
    let success: Bool?
}

struct TariffResponse: Codable {
    let usage, parking, transfer: Price?

    struct Price: Codable {
        let price: Int
    }

    enum CodingKeys: String, CodingKey {
        case usage, parking, transfer
    }
}
