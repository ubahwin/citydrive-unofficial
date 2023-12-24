import Foundation

struct SessionIDResponse: Codable {
    let sessionID: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case success
    }
}
