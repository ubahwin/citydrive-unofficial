import Foundation

protocol RepositoryProtocol {
    associatedtype Entity

    func create(entity: Entity)
    func read() -> Entity?
    func update(entity: Entity)
    func delete(entity: Entity)
}
