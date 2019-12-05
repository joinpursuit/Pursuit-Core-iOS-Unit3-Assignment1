//
//  UserInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liubov Kaper  on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct User: Decodable {
    var results: [UserDetails]
}

struct UserDetails: Decodable {
    var name: Name
    var location: Location
    var email: String 
}
struct Name: Decodable {
    var first: String
    var last: String
    
}
struct Location: Decodable {
    var city: String
}

extension User {
    
    static func getUserInfo() -> [UserDetails] {
        var users = [UserDetails]()
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
          let data = try Data(contentsOf: fileURL)
            let userInfoData = try JSONDecoder().decode(User.self, from: data)
            users = userInfoData.results
            users = userInfoData.results.sorted {$0.name.first < $1.name.first}
        } catch {
            fatalError("failed to load contents \(error)")
        }
        
        
        return users
    }
}
