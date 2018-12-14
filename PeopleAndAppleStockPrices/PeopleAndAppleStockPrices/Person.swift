//
//  Person.swift
//  PeopleAndAppleStockPrices
//
//  Created by Nathalie  on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let results: [User]
}

struct User: Codable {
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }

    let name: Name
    
    struct Location: Codable {
        let city: String
    }
    struct Picture: Codable {
        let large: String?
        let medium: String?
        let thumbnail: String?
    }
    let location: Location
    let email: String
    let picture: Picture
}
