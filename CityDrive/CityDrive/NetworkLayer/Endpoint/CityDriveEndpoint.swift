//
//  DataEndpoint.swift
//  CityDrive
//
//  Created by Иван Вдовин on 18.06.2023.
//

import Foundation

public enum CityDriveApi {
    case sendPhone(phone: String)
    case sendSms(phone: String, smsCode: Int)
    case getOrders
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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .sendSms: return .post
        case .sendPhone: return .post
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
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
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
        }
    }
}

extension CityDriveApi {
    var urlParameters: [String : String] {
        switch self {
        default: return ["version" : "20"]
        }
    }
}
