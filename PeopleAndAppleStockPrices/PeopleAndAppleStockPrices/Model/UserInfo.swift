//
//  UserInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Biron Su on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [UserInfo]
}
struct UserInfo: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let picture: PictureWrapper
}
struct NameWrapper: Codable {
    let first: String
    let last: String
    public var fullName: String {
        return "\(first) \(last)"
    }
}
struct LocationWrapper: Codable {
    let city: String
    let state: String
}
struct PictureWrapper: Codable {
    let large: URL
}
