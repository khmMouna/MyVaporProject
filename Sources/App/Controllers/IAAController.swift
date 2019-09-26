import Vapor
import FluentSQLite

struct IAAController {

    func index(_ req: Request) throws -> Future<[IAAMessage]> {
        return IAAMessage.query(on: req).all()
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<IAAMessage> {
        return try req.content.decode(IAAMessage.self).flatMap { message in
            return message.save(on: req)
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.content.decode(IAAMessage.self).flatMap { message in
            return message.delete(on: req)
        }.transform(to: .ok)
    }
    
}
