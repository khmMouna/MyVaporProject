import Vapor
import FluentSQLite

struct IAATypeController {
    
    func index(_ req: Request) throws -> Future<[IAAType]> {
        return IAAType.query(on: req).all()
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<IAAType> {
        return try req.content.decode(IAAType.self).flatMap { type in
            return type.save(on: req)
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.content.decode(IAAType.self).flatMap { type in
            return type.delete(on: req)
        }.transform(to: .ok)
    }
    
}
