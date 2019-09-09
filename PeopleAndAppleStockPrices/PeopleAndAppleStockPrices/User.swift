//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Rifkin on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: Name
    let location: Location
    
    struct Name: Codable {
        let title: String
        private let firstName: String
        private let lastName: String
        var fullName: String {
            return "\(firstName) \(lastName)"
        }
        
        private enum CodingKeys: String, CodingKey {
            case title
            case firstName = "first"
            case lastName = "last"
        }
    }
    
    struct Location: Codable {
        private let street: String
        private let city: String
        var address: String {
            return "\(street), \(city)"
        }
    }
}
