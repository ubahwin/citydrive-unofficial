//
//  ErrorResponse.swift
//  CityDrive
//
//  Created by Иван Вдовин on 21.07.2023.
//

import Foundation

struct ErrorResponse: Codable { // TODO: обрабатывать ошибки в структуру и говорить пользователю об ошибке
    let success: Bool?
    let name, message, text: String?
    let status, code: Int?
}
