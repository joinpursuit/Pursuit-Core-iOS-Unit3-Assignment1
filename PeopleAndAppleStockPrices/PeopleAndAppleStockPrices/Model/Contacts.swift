//
//  Contacts.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jane Zhu on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Contacts: Codable {
    let results: [ContactInfo]
}

struct ContactInfo: Codable {
    let name: NameWrapper
    let email: String
    let location: LocationWrapper
    let picture: PictureWrapper
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
}

struct LocationWrapper: Codable {
    let state: String
}

struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
