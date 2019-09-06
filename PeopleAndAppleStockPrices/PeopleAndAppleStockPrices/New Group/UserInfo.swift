//
//  UserInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var city: String
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case city = "city"
    }
    
    static func getUser(from data: Data) throws -> [User] {
        do {
            let user = try JSONDecoder().decode([User].self, from: data)
            return user
        } catch {
            throw ErrorHandling.decodingError
        }
        
    }
}
