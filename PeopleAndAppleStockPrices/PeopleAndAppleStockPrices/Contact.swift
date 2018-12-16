//
//  Contact.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jeffrey Almonte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Contact: Codable {
    let results:[ContactInfo]
}
struct ContactInfo: Codable {
    let name: Name
    let location: Location
    let email: String
    let picture: Picture
}
struct Name: Codable {
    let first: String
    let last: String
    
    public var fullName: String {
        return first.capitalized + " " +  last.capitalized
    }
    
}
struct Location: Codable {
    let state: String
}
struct Picture: Codable {
    let thumbnail: String
    let medium: String
    let large: String
}
