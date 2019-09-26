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
    
    router.get("users") { req -> Future<View> in
      return User.query(on: req).all().flatMap { users in
        let data = ["userlist": users]
        return try req.view().render("userview", data)
      }
    }
    
    router.post("users") { req -> Future<Response> in
      return try req.content.decode(User.self).flatMap { user in
        return user.save(on: req).map { _ in
          return req.redirect(to: "users")
        }
      }
    }
    
    router.get("messages") { req -> Future<View> in
      return IAAMessage.query(on: req).all().flatMap { messages in
        let data = ["messageList": messages]
        return try req.view().render("messageview", data)
      }
    }

    router.get("types") { req -> Future<View> in
      return IAAType.query(on: req).all().flatMap { users in
        let data = ["typeList": users]
        return try req.view().render("typeview", data)
      }
    }
    
    
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
    
    
    // User controller
    let userController = UserController()
    router.get("getUsers", use: userController.index)
    router.post("postUser", use: userController.create)
    //router.delete("deleteUser", User.parameter, use: userController.delete)
    
    // Message controller
    let messageController = IAAController()
    router.get("getMessages", use: messageController.index)
    router.post("postMessage", use: messageController.create)
    //router.delete("deleteUser", User.parameter, use: userController.delete)
    
    // Type controller
    let typeController = IAATypeController()
    router.get("getTypes", use: typeController.index)
    router.post("postType", use: typeController.create)
    //router.delete("deleteUser", User.parameter, use: userController.delete)
    
}
