//
//  UserInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct UserInformation:Codable{
    var results: [Person]
}

struct Person: Codable {
    var gender: String
    var name:Name
    var location: Location
    var email: String
    var login: LoginInfoWrapper
    var dob: String
    var registered: String
    var phone: String
    var cell: String
    var id:Identity
    var picture: Picture
}
struct Name: Codable{
    var title: String
    var first: String
    var last: String
    var fullName: String {
        return "\(first) \(last)".capitalized
    }
}
struct Location: Codable {
    var street: String
    var city: String
    var state: String
    var postcode: String
}
struct LoginInfoWrapper: Codable {
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}

struct Identity:Codable {
    var name: String
    var value: String
}
struct Picture:Codable {
    var large: URL
    var medium: URL
    var thumbnail: URL
}

