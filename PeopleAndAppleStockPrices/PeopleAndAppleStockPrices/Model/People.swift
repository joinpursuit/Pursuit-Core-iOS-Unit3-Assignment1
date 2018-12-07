//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by Leandro Wauters on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct People: Codable {
    struct searchData: Codable{
        let results: [People]
    }
    let name: NameWrapper
    let location: LocationWrapper
    let picture: PictureWrapper
    let email: String
    
}
struct NameWrapper: Codable{
    var first: String
    var last: String
}

struct LocationWrapper: Codable{
    var city: String
}

struct PictureWrapper: Codable {
    var large: URL
}
