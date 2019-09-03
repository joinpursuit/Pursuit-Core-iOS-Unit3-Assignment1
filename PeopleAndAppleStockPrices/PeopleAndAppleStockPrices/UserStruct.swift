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
    
    static func formattedName(index: Int, userArray: [User]) -> String {
        let fullName = "\(userArray[index].name.title.capitalized). \(userArray[index].name.first.capitalized) \(userArray[index].name.last.capitalized)"
        return fullName
    }
    
    static func formattedAddress(index: Int, userArray: [User]) -> String {
        let fullAddress = "\(userArray[index].location.street.capitalized)  \(userArray[index].location.city.capitalized), \(userArray[index].location.state.capitalized)  \(userArray[index].location.postcode.capitalized)"
        return fullAddress
    }
    
}

struct NameWrapper : Codable {
    let title: String
    let first: String
    let last: String
}

struct LocationWrapper : Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}


