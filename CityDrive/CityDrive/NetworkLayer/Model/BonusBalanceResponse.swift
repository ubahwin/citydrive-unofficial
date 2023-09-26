import Foundation

struct BonusBalanceResponse: Codable {
    var balance: Int?

    enum CodingKeys: String, CodingKey {
        case balance
    }
}
