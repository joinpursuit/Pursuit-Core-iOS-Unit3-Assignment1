import Foundation

struct UserWrapper: Codable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

struct User: Codable {
    let gender: String
    let name: Name
    let email: String
    let location: Location
    let cell: String
    
    static func getUsers(from data: Data) -> [User] {
        
        do {
            let wrapper = try
                JSONDecoder().decode(UserWrapper.self, from: data)
            return wrapper.users
        } catch {
            fatalError("Decoding Error")
        }
    }
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let city: String
}
