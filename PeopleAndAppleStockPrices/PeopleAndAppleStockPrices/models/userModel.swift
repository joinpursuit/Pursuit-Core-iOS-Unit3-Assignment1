//
//  userModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserBase: Codable {
    let results: [User]
    static func getJokes(fron data: Data) -> UserBase{
        do {
            let newUser = try
                JSONDecoder().decode(UserBase.self, from: data)
            return newUser
        } catch let decodeError {
            fatalError("could not decode info\(decodeError)")
        }
    }
}
struct User: Codable{
    let gender: String
    let name: fullName
    let location: fullAddress
    let email: String
    let phone: String
    let picture: picSize
    let dob: String
}
struct fullName:Codable{
    let title: String
    let first: String
    let last: String
}
struct fullAddress: Codable{
    let street: String
    let city: String
    let state: String
}
struct picSize: Codable{
    let large: String
}
