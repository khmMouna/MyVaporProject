import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class UserController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    /// Deletes a parameterized `Todo`.
//    func delete(_ req: Request) throws -> Future<HTTPStatus> {
//        return try req.content.decode(User.self).flatMap { user in
//            return user.delete(on: req)
//        }.transform(to: .ok)
//    }
}
