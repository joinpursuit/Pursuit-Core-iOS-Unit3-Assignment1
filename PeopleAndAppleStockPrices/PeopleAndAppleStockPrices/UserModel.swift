//
//  UserModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct People: Codable {
    let results: [Person]
    
    static func getUsers(from data: Data) -> [Person] {
        do {
            let users = try JSONDecoder().decode(People.self, from: data)
            return users.results
        } catch {
            fatalError("could not decode info \(error)")
        }
    }
    
}

struct Person: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let dob: String
    let email: String
}

struct NameWrapper: Codable {
    let first: String
    let last: String
    var fullyNamed: String {
        return "\(first.capitalized) \(last.capitalized)"
    }
}

struct LocationWrapper: Codable {
    let city: String
    
}
