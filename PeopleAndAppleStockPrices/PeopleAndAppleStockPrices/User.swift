//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let location: Location
    let email: String
    let cell: String
    
    static func getUsers(from data: Data) throws -> [User] {
        do {
        let userWrapper = try JSONDecoder().decode(UserWrapper.self, from: data)
            return userWrapper.results
        } catch {
            throw error
        }
    }
}

struct Name: Codable {
    let first: String
    let last: String
    var full: String {
        first.capitalized + " " + last.capitalized
    }
    
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
    var address: String {
        "\(street), \(city), \(state), \(postcode)"
    }
}
