//
//  UserModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by 马文龙 on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
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
