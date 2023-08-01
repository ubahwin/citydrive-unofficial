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
    case getCarStatus
    case getBonusCount
    case getUser
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
        case .getCarStatus: return "status"
        case .getBonusCount: return "bonus-balance"
        case .getUser: return "user"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .sendSms: return .post
        case .sendPhone: return .post
        default: return .get
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
        case .getCarStatus:
            return .requestParametersAndHeaders(
                bodyParameters: body,
                urlParameters: urlParameters,
                additionHeaders: headers
            )
        case .getBonusCount:
            return .requestParametersAndHeaders(
                bodyParameters: body,
                urlParameters: urlParameters,
                additionHeaders: headers
            )
        case .getUser:
            return .requestParametersAndHeaders(
                bodyParameters: body,
                urlParameters: urlParameters,
                additionHeaders: headers
            )
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getOrders, .getOrder, .getBonusCount: return [
            "User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        case .getCarStatus: return [
            "User-Agent": "PostmanRuntime/7.32.3",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        case .getUser: return [
            "User-Agent": "carsharing/4.13.1 (Linux; Android 10; Android SDK built for arm64 Build/REL)",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        default: return ["User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)"]
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
        case .getCarStatus: return [
            "lat": 37.4219983,
            "lon": -122.084,
            "version" : 20,
            "session_id": (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        default: return ["version" : 20]
        }
    }
}
