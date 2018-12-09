//
//  Person.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Person: Codable {
    
    struct searchData: Codable {
        let results: [Person]
    }
    
    struct FullName: Codable {
        let first: String
        let last: String
    }
    
    struct Address: Codable {
        let city: String
        let state: String
    }
    
    struct PictureType: Codable {
        let large: URL
    }
    
    let name: FullName
    let location: Address
    let email: String
    let cell: String
    let picture: PictureType
}
