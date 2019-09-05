//
//  userModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum UserJSONError: Error {
    case decodingError(Error)
}

struct UserWrapper: Codable {
    
    let results: [UserInfo]
    
    static func getUserData(from data: Data) throws -> [UserInfo]{
        do{
            let users = try JSONDecoder().decode(UserWrapper.self, from: data)
            return users.results
        } catch {
            throw UserJSONError.decodingError(error)
        }
    }
    
}

struct UserInfo: Codable{
    let name: NameInfo
    let location: LocationInfo
    let email: String
}

struct NameInfo: Codable {
    let title: String
    let first: String
    let last: String
    var fullName: String{
        let name = "\(title.capitalized) \(first.capitalized) \(last.capitalized)"
        return name
    }
}

struct LocationInfo: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
    var fullAddress: String{
        let address = "\(street.capitalized) \(city.capitalized), \(state.capitalized) \(postcode)"
        return address
    }
}
