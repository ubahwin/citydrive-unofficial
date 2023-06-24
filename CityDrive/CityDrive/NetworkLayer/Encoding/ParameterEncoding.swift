//
//  ParameterEncoding.swift
//  CityDrive
//
//  Created by Иван Вдовин on 17.06.2023.
//

import Foundation

public typealias Parameters = [String : Any]

protocol ParameterEncoding {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
