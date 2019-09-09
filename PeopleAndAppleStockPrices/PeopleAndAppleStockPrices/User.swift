//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Rifkin on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let results: [User]
}

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
    
    static func getUsers() -> [User] {
        guard let fileName = Bundle.main.path(forResource: "userinfo", ofType: "json") else {fatalError()}
        guard let fileURL = URL(string: fileName) else {fatalError()}
        
        do {
            let data = try Data(contentsOf: fileURL)
            let userWrapper = try JSONDecoder().decode(UserWrapper.self, from: data)
            return userWrapper.results
        } catch {
            fatalError()
        }
    }
}
