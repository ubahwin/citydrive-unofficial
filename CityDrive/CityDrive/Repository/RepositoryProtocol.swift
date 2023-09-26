//
//  RepositoryProtocol.swift
//  CityDrive
//
//  Created by Иван Вдовин on 25.09.2023.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Entity

    func create(entity: Entity)
    func read() -> Entity?
    func update(entity: Entity)
    func delete(entity: Entity)
}
