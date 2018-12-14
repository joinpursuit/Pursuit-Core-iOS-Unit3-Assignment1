//
//  peoplestruct.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 12/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct People: Codable {
  let results:[PeoplesInfo]
}
struct PeoplesInfo: Codable {
    let name: nameinfo
    let location: locationInfo
    let email: String
    let picture: PictureInfo
}
struct nameinfo: Codable {
    let title: String
    let first: String
    let last: String
}
struct locationInfo: Codable{
    let city: String
}
struct PictureInfo: Codable {
    let medium: String
    let thumbnail: String
}
