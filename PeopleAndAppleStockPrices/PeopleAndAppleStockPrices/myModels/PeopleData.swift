//
//  PeopleData.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit
struct ContactDetails : Codable {
    struct Contacts : Codable {
        let results :[ContactDetails]
    }
    struct NameWrapper : Codable {
        let first : String
        let last : String
    }
    let name : NameWrapper
    struct LocationWrapper : Codable {
        let street : String
        let city : String
        let state : String
        let postcode : String
    }
    let location : LocationWrapper
    let email : String
    let dob : String
    let phone : String
    let cell : String
    struct PictureWrapper : Codable {
        let large : String
        let medium : String
        let thumbnail : String
    }
    let picture : PictureWrapper
}
