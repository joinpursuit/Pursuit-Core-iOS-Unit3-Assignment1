//
//  UserInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct UserInformation:Codable{
    var results: [resultsWrapper]
}

struct resultsWrapper: Codable {
    var gender: String
    var name:fullNameWrapper
    var location: locationWrapper
    var email: String
    var login: LoginInfoWrapper
    var dob: String
    var registered: String
    var phone: String
    var cell: String
    var id:identityWrapper
    var picture: pictureWrapper
}
struct fullNameWrapper: Codable{
    var title: String
    var first: String
    var last: String
}
struct locationWrapper: Codable {
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

struct identityWrapper:Codable {
    var name: String
    var value: String
}
struct pictureWrapper:Codable {
    var large: URL
    var medium: URL
    var thumbnail: URL
}

