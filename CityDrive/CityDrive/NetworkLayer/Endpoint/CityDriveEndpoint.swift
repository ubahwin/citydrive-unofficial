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

    // отправить токен ВК для получения session_id
    case sendTokenVK(token: String, uuid: String)

    // запросить список поездок, где limit количество поездок, а page страница размером в limit поездок
    case getOrders(page: Int, limit: Int)

    // запросить поездку по id, version определяет количество информации 
    // (0 – больше информации, 20 – та, что приходит на офиц. клиент)
    case getOrder(id: String, version: Int)

    // запросить текущие местоположения автомобилей
    case getCarStatus

    // запросить количество бонусов
    case getBonusCount

    // запросить данные о пользователе
    case getUser
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
        case .sendTokenVK: return "signup/vk-connect"
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
        case .sendSms, .sendPhone, .sendTokenVK: return .post

        default: return .get
        }
    }

    var task: HTTPTask {
         return .requestParametersAndHeaders(
            bodyParameters: body,
            urlParameters: urlParameters,
            additionHeaders: headers
        )
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getOrders, .getOrder, .getBonusCount: return [
            "User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        case .getCarStatus: return [
            // статус можно получить почему-то только с такого User-Agent (Postman) -_-
            "User-Agent": "PostmanRuntime/7.32.3",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        case .getUser: return [
            // данные о пользователе можно получить почему-то только с такого User-Agent -_-
            "User-Agent": "carsharing/4.13.1 (Linux; Android 10; Android SDK built for arm64 Build/REL)",
            "Cookie": "session_id=" + (KeychainWrapper.standard.string(forKey: "sessionID") ?? "")
        ]
        default: return ["User-Agent": "carsharing/4.13.1 (Linux; Android 12; M2101K7BNY Build/REL)"]
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
        case .sendTokenVK(let token, let uuid): return [
            "vk_token": token,
            "uuid": uuid
        ]
        default: return nil
        }
    }
}

extension CityDriveApi {
    var urlParameters: Parameters? {
        switch self {
        case .getOrders(let page, let limit): return [
            "type": "user",
            "limit": limit,
            "page": page,
            "version": 20
        ]
        case .getOrder(_, let version): return ["version": version]
        case .getCarStatus: return [
            // нужны координаты, но зачем...
            "lat": 0,
            "lon": 0
        ]
        default: return ["version": 20]
        }
    }
}
