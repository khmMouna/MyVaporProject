import FluentSQLite
import Vapor

final class IAAType: SQLiteModel {
    
    var id: Int?
    var name: String
    
    init(id: Int? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

extension IAAType: Content {}
extension IAAType: Migration {}
