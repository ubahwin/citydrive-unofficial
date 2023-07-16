//
//  DataEndpoint.swift
//  CityDrive
//
//  Created by Иван Вдовин on 18.06.2023.
//

import Foundation
import SwiftKeychainWrapper

public enum CityDriveApi {
    case sendPhone(phone: String)
    case sendSms(phone: String, smsCode: Int)
    case getOrders(page: Int, limit: Int)
    case getOrder(id: String, version: Int)
}

extension CityDriveApi: EndpointType {
    var environmentBaseURL : String {
        return "https://api.citydrive.ru/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .sendSms: return "signup/code"
        case .sendPhone: return "signup"
        case .getOrders: return "orders"
        case .getOrder(let id, _): return "order/" + id + "/details"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .sendSms: return .post
        case .sendPhone: return .post
        case .getOrders: return .get
        case .getOrder: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .sendPhone: return .requestParametersAndHeaders(
            bodyParameters: body,
            urlParameters: urlParameters,
            additionHeaders: headers
        )
        case .sendSms:
            return .requestParametersAndHeaders(
                bodyParameters: body,
                urlParameters: urlParameters,
                additionHeaders: headers
            )
        case .getOrders:
            return .requestParametersAndHeaders(
                bodyParameters: body,
                urlParameters: urlParameters,
                additionHeaders: headers
            )
        case .getOrder:
            return .requestParametersAndHeaders(
                bodyParameters: body,
                urlParameters: urlParameters,
                additionHeaders: headers
            )
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getOrders, .getOrder: return [
            "User-Agent" : "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)",
            "Cookie" : "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "") // TODO: sessionID
        ]
        default: return ["User-Agent" : "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)"]
        }
    }
    
    var body: Parameters? {
        switch self {
        case .sendPhone(let phone): return [
            "os": "android",
            "phone": phone,
            "phone_code": "7",
            "vendor_id": "86bdb8236b314b96"
        ]
        case .sendSms(let phone, let smsCode): return [
            "os": "android",
            "code": smsCode,
            "vendor_id": "86bdb8236b314b96",
            "phone": phone,
            "phone_code": "7"
        ]
        default: return nil
        }
    }
}

extension CityDriveApi {
    var urlParameters: Parameters? {
        switch self {
        case .getOrders(let page, let limit): return [
            "type" : "user",
            "limit" : limit,
            "page" : page,
            "version" : 20
        ]
        case .getOrder(_, let version): return ["version" : version]
        default: return ["version" : "20"]
        }
    }
}
