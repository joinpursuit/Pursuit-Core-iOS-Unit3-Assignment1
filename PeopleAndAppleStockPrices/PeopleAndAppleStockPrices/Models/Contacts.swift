//
//  Contacts.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Results: Codable {
    let contacts: [Contact]
    
    static func getContacts(from data: Data) -> [Contact] {
        do {
            let contactResults = try JSONDecoder().decode(Results.self, from: data)
            return contactResults.contacts
        } catch let decodeError {
            fatalError("Error: \(decodeError)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case contacts = "results"
    }
}

struct Contact: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let phone: String
    let cell: String
    
    struct NameWrapper: Codable {
        let first: String
        let last: String
    }
    
    struct LocationWrapper: Codable {
        let street: String
        let city: String
        let state: String
    }
    
}

