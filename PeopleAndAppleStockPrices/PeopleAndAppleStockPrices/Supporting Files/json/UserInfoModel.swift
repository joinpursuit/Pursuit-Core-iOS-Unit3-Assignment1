//
//  UserInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let results: [User]
}

struct User: Decodable {
    let name: Name
    let location: Location
    let email: String
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Location: Decodable {
    let city: String
}

struct MovieData: Decodable {
    let results: [Episode]
}


struct Episode: Decodable {
    let title: String
    let crawl: String
    //opening_crawl: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case crawl = "opening_crawl"
    }
}

extension UserData {
    static func getUserData() -> [User] {
        var users = [User]()
        
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            
            let userInfo = try JSONDecoder().decode(UserData.self, from: data)
            users = userInfo.results.sorted {$0.name.first < $1.name.first}
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return users
    }
}



