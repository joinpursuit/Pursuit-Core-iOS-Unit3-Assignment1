//
//  PeopleData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ramu on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct PeopleData: Codable{
    let results: [resultWrapper]
}
struct resultWrapper: Codable {
    let name: NameWrapper
    let email: String
    let location: LocationWrapper
    let picture: ImageWrapper
}
struct NameWrapper: Codable {
    let first: String
    let last: String
    var fullName: String {
        return "\(first) \(last)".capitalized
    }
}
struct LocationWrapper: Codable {
    let state: String
}
struct ImageWrapper: Codable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}


