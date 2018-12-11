//
//  ModelOfUserInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    let results: [ResultsToSet]
}
struct ResultsToSet: Codable {
    let location: StringToSet
    let name: StringWrapper
    let picture: Picture
    let email: String
}
struct StringWrapper: Codable {
    let title: String
    let first: String
    let last: String
}

struct StringToSet: Codable {
    let street: String
    let city: String
}
struct Picture: Codable {
    let large: URL
}
