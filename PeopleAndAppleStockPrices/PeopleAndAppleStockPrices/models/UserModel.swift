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
    static func decodeUser(data: Data)-> [User]{
        do {
            let userDecoded = try JSONDecoder().decode(UserBase.self, from: data)
            return userDecoded.results
        }
        catch{
            print(error)
            return []
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
    let dob: birthday
    func sortMe(users: [User]) -> [User] {
        let sorted: [User] = users.sorted { $0.name.first < $1.name.first }
    return sorted
        }
    }
struct fullName:Codable{
    let title: String
    let first: String
    let last: String
    func FullName ()-> String {
        return "\(first.capitalized) \(last.capitalized)"
    }
}
struct fullAddress: Codable{
//    let street: String
    let city: String
    let state: String
}
struct picSize: Codable{
    let large: String
}

struct birthday: Codable {
    let date: String
}


