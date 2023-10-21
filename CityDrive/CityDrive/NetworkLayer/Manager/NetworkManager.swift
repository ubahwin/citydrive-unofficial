import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> { // TODO: potom
    case success
    case failure(String)
}

class NetworkManager {
    let router = Router<CityDriveApi>()

    fileprivate func processResponse<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (_ success: T?, _ error: String?) -> Void
    ) {
        if error != nil {
            completion(nil, "Please check your network connection.")
        }

        guard let response = response as? HTTPURLResponse else {
            completion(nil, NetworkResponse.failed.rawValue)
            return
        }

        let result = handleNetworkResponse(response)

        switch result {
        case .success:
            guard let responseData = data else {
                completion(nil, NetworkResponse.noData.rawValue)
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                completion(apiResponse, nil)
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        case .failure(let networkFailureError):
            completion(nil, networkFailureError)
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    func sendPhone(
        phone: String,
        completion: @escaping (_ success: SendPhoneSuccessResponse?, _ error: String?) -> Void
    ) {
        router.request(.sendPhone(phone: phone)) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func sendSms(
        phone: String,
        smsCode: Int,
        completion: @escaping (_ success: SessionIDResponse?, _ error: String?) -> Void
    ) {
        router.request(.sendSms(phone: phone, smsCode: smsCode)) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func sendTokenVK(
        token: String,
        uuid: String,
        completion: @escaping (_ success: SessionIDResponse?, _ error: String?) -> Void
    ) {
        router.request(.sendTokenVK(token: token, uuid: uuid)) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func getOrders(
        page: Int,
        limit: Int,
        completion: @escaping (_ success: OrderListResponse?, _ error: String?) -> Void
    ) {
        router.request(.getOrders(page: page, limit: limit)) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func getOrder(
        id: String,
        completion: @escaping (_ success: OrderResponse?, _ error: String?) -> Void
    ) {
        router.request(.getOrder(id: id, version: 0)) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func getOrder(
        id: String,
        version: Int,
        completion: @escaping (_ success: MiddleOrderResponse?, _ error: String?) -> Void
    ) {
        router.request(.getOrder(id: id, version: version)) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func getCarStatus(
        completion: @escaping (_ success: CarStatusResponse?, _ error: String?) -> Void
    ) {
        router.request(.getCarStatus) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func getBonusCount(
        completion: @escaping (_ success: BonusBalanceResponse?, _ error: String?) -> Void
    ) {
        router.request(.getBonusCount) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }

    func getUser(
        completion: @escaping (_ success: FullUserResponse?, _ error: String?) -> Void
    ) {
        router.request(.getUser) { data, response, error in
            self.processResponse(data: data, response: response, error: error, completion: completion)
        }
    }
}
