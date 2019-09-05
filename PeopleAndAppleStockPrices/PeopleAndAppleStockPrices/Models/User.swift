//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let results: [User]
    
    static func getAllUsers(from JSONData: Data ) -> UserWrapper? {
        do {
            let allUsers = try JSONDecoder().decode(UserWrapper?.self, from: JSONData)
            return allUsers
        } catch {
            return nil
        }
    }
}

struct User: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let picture: ImageWrapper
}

struct NameWrapper: Codable {
    let firstName: String
    let lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
}

struct LocationWrapper: Codable {
    let state: String
}

struct ImageWrapper: Codable {
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "large"
    }
}
