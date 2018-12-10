//
//  PeopleList.swift
//  PeopleAndAppleStockPrices
//
//  Created by Matthew Huie on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct People: Codable {
    let results: [ResultsWrapper]
}

struct ResultsWrapper: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let picture: PictureWrapper
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
}

struct LocationWrapper: Codable {
    let street: String
    let city: String
    let state: String
}

struct PictureWrapper: Codable {
    let large: URL
}
