//
//  DataEndpoint.swift
//  CityDrive
//
//  Created by Иван Вдовин on 18.06.2023.
//

import Foundation
import SwiftKeychainWrapper

public enum CityDriveApi {
    
    // отправить смс на телефон
    case sendPhone(phone: String)
    
    // отправить полученную смс для получения session_id
    case sendSms(phone: String, smsCode: Int)
    
    // запросить список поездок, где limit количество поездок, а page страница размером в limit поездок
    case getOrders(page: Int, limit: Int)
    
    // запросить поездку по id, version определяет количество информации (0 – больше информации, 20 – та, что приходит на офиц. клиент)
    case getOrder(id: String, version: Int)
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
    
    // запросить текущие местоположения автомобилей
    case getCarStatus
    
    // запросить количество бонусов
    case getBonusCount
    
    // запросить данные о пользователе
    case getUser
>>>>>>> Stashed changes
=======
    case getCarStatus
    case getBonusCount
    case getUser
>>>>>>> origin/main
}

extension CityDriveApi: EndpointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.citydrive.ru/") else { fatalError("baseURL could not be configured.")}
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
        // только для входа требуется POST запрос
        case .sendSms: return .post
        case .sendPhone: return .post
<<<<<<< HEAD
<<<<<<< Updated upstream
        case .getOrders: return .get
        case .getOrder: return .get
=======
            
        default: return .get
>>>>>>> Stashed changes
=======
        default: return .get
>>>>>>> origin/main
        }
    }
    
    var task: HTTPTask {
         return .requestParametersAndHeaders(
            bodyParameters: body,
            urlParameters: urlParameters,
            additionHeaders: headers
        )
<<<<<<< Updated upstream
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
=======
>>>>>>> Stashed changes
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getOrders, .getOrder, .getBonusCount: return [
            "User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
<<<<<<< HEAD
<<<<<<< Updated upstream
        default: return ["User-Agent" : "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)"]
=======
        case .getCarStatus: return [
            // статус можно получить почему-то только с такого User-Agent (Postman) -_-
=======
        case .getCarStatus: return [
>>>>>>> origin/main
            "User-Agent": "PostmanRuntime/7.32.3",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        case .getUser: return [
<<<<<<< HEAD
            // данные о пользователе можно получить почему-то только с такого User-Agent -_-
=======
>>>>>>> origin/main
            "User-Agent": "carsharing/4.13.1 (Linux; Android 10; Android SDK built for arm64 Build/REL)",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        default: return ["User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)"]
<<<<<<< HEAD
>>>>>>> Stashed changes
=======
>>>>>>> origin/main
        }
    }
    
    var body: Parameters? {
        switch self {
        // параметры только при входе
        case .sendPhone(let phone): return [
            "os": "android",
            "phone": phone,
            "phone_code": "7",
            // неизвестно что за vendor_id, но...
            "vendor_id": "86bdb8236b314b96"
        ]
        case .sendSms(let phone, let smsCode): return [
            "os": "android",
            "code": smsCode,
            // неизвестно что за vendor_id, но...
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
<<<<<<< HEAD
<<<<<<< Updated upstream
        default: return ["version" : "20"]
=======
        case .getCarStatus: return [
            // нужны координаты, но зачем...
            "lat": 0,
            "lon": 0
        ]
        default: return ["version" : 20]
>>>>>>> Stashed changes
=======
        case .getCarStatus: return [
            "lat": 37.4219983,
            "lon": -122.084,
            "version" : 20,
            "session_id": (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        default: return ["version" : 20]
>>>>>>> origin/main
        }
    }
}
