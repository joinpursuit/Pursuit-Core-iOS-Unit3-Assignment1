import Foundation


enum JSONError: Error {
    case decodingError(Error)
}


struct UserMode: Codable {
    let results: [ResultsWrapper]
}

struct ResultsWrapper: Codable {
    let name: userNameWrapper
    let email:String
    let location: locationWrapper
    let picture: pictureWrapper
   
    
    
    
    static func getUser(from data: Data) throws -> [ResultsWrapper] {
        do {
            let results = try JSONDecoder().decode(UserMode.self, from: data)
            return results.results
        } catch {
            throw JSONError.decodingError(error)
        }
    }
    
    func getFullName () -> String {
        let title = name.title.capitalized
        let firstName = name.first.capitalized
        let lastName = name.last.capitalized
        return "\(title). \(firstName) \(lastName)"
    }
    
    func getLocation () -> String {
        let street = location.street.capitalized
        let city = location.city.capitalized
        let state = location.state.capitalized
        return "\(street), \(city), \(state)"
    }
}




struct userNameWrapper: Codable {
    let title: String
    let first: String
    let last: String
}


struct locationWrapper: Codable {
    let street :String
    let city: String
    let state: String
//    let postalcode: Int
}

struct pictureWrapper: Codable {
    let large: String
}
