//
//  UserModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let results: [User]
}
struct User: Codable {
//    let gender: String
    let name: UserName
    let location: UserLocation
    let email: String
    let picture: UserPicture
    
}
struct UserName: Codable {
//    let title: String
    let first: String
    let last: String
}
struct UserLocation: Codable {
    let city: String
}
struct UserPicture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
