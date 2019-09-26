import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    router.get("welcome") { req -> Future<View> in
        //return try req.view().render("welcome", ["names": ["Jill", "Eve", "John"]])
        let message1 = Message(id:"23456", alert:"banner", position:"Top")
        let message2 = Message(id:"65378", alert:"interstitial", position:"Bottom")
        let message3 = Message(id:"23876", alert:"banner", position:"Top")
        let table = WelcomeContext(titles: ["Id", "Alert", "Message"], messages:[message1, message2, message3])
        return try req.view().render("welcome", table)
    }
    
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    struct Type: Codable {
        var id:String
        var name:String
        
    }
    
    struct Message: Codable {
        var id: String
        var alert: String
        var position: String
    }
    
    struct WelcomeContext: Codable {
        var titles: [String]
        var messages: [Message]
    }
}
