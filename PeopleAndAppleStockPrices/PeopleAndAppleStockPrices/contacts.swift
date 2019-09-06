//
//  contacts.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jack Wong on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Contacts: Codable{
    let results: [ContactInfo]
}

struct ContactInfo: Codable{
    let gender: String
    let name: NameWrapper
    
  
    let location: LocationWrapper
    let email: String
//    let login: LoginWrapper
//    let dob: String
//    let registered: String
//    let phone: String
//    let cell: String
//    let id: IDWrapper
    
    let picture: PictureWrapper
    
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
    
    var fullname: String {
        return "\(first) \(last)"
    }
}

struct LocationWrapper: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

//struct LoginWrapper: Codable {
//    let username: String
//    let password: String
//    let salt: String
//    let md5: String
//    let sha1: String
//    let sha256: String
//}
//

struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
