import Foundation

struct SendPhoneSuccessResponse: Codable {
    let step: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case step, success
    }
}
