import Foundation

public typealias Parameters = [String: Any]

protocol ParameterEncoding {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
