//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by hildy abreu on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct UserInfoData: Codable {
    let results: [PeopleInfo]
    
    static func getUserInfoData(data: Data) throws -> [PeopleInfo] {
        do {
            let userInfoData = try JSONDecoder().decode(UserInfoData.self, from: data)
            return userInfoData.results
        }
        catch {
            throw error
        }
    }
}
struct PeopleInfo: Codable {
    let name: NameInfo
    let location: LocationInfo
    let email: String
    let picture: PictureInfo
}

struct NameInfo: Codable {
    let first: String
    let last: String
}

struct LocationInfo: Codable {
    let city: String
    let state: String
}

struct PictureInfo: Codable {
    let large: String
    let medium: String

}
