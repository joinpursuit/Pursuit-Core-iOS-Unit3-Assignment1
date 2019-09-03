//
//  UserModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let results: [User]
    
    static func getUsers(from data: Data) -> [User]? {
        do {
            let newUser = try JSONDecoder().decode(UserWrapper.self, from: data)
            return newUser.results
        } catch {
            return nil
        }
    }
}

struct User: Codable {
    let name: Name
    let email: String
    let phone: String
    let dob: String
    let location: Location
    
    func getFullName() -> String {
        let capTitle = name.title.capitalized
        let capFirst = name.first.capitalized
        let capLast = name.last.capitalized
        
        return "\(capTitle). \(capFirst) \(capLast)"
    }
    
    func getFullAddress() -> String {
        return """
        \(self.location.street)
        \(self.location.city), \(self.location.state), \(self.location.postcode!)
        """
    }
    
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}


struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String?
    
    private enum CodingKeys: String, CodingKey {
        case street = "street", city = "city", state = "state", postcode = "postcode"
    }
    
    init(street: String, city: String, state: String, postcode: String? ) {
        self.street = street
        self.city = city
        self.state = state
        self.postcode = postcode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(String.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        
        if let value = try? container.decode(Int.self, forKey: .postcode) {
            postcode = String(value)
        } else {
            postcode = try container.decode(String.self, forKey: .postcode)
        }
    }
    
}
