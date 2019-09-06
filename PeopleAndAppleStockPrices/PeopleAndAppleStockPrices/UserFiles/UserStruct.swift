//
//  UserStruct.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit


struct UserWrapper : Codable {
    let results: [User]
    
    static func getUserData(from data: Data) throws -> [User] {
        do {
            let userData = try JSONDecoder().decode(UserWrapper.self, from: data)
            
            return userData.results
        } catch {
            print(error)
            throw error
        }
    }
}


struct User : Codable {
    let gender: String
    let name: NameWrapper
    let location : LocationWrapper
    let email: String
    let cell: String
}

struct NameWrapper : Codable {
    let title: String
    let first: String
    let last: String
    var fullname: String {
       let name = "\(first.capitalized) \(last.capitalized)"
        return name
    }
}

struct LocationWrapper : Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
    var fullAddress: String {
        let address = "\(street.capitalized)  \(city.capitalized), \(state.capitalized)  \(postcode)"
        return address
    }
}


