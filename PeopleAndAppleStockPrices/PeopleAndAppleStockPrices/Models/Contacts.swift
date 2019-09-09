//
//  Contacts.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Contacts: Codable {
    let people: [Person]?
    
    private enum CodingKeys: String, CodingKey {
        case people = "results"
    }
}

struct Person: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let picture: PictureWrapper
    let email: String?
}

struct NameWrapper: Codable {
    let title: String?
    let first: String?
    let last: String?
}

struct LocationWrapper: Codable {
    let street: String?
    let city: String?
    let state: String?
}

struct PictureWrapper: Codable {
    let large: URL?
}
