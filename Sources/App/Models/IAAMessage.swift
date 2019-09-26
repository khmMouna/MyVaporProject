import FluentSQLite
import Vapor

final class IAAMessage: SQLiteModel {
    
    var id: Int?
    var alert:String
    var position: String
    
    enum Position {
        case top, center, bottom
    }
    
    init(id: Int? = nil, alert:String, position:String) {
        self.id = id
        self.alert = alert
        self.position = position
    }
}
extension IAAMessage: Content {}
extension IAAMessage: Migration {}
