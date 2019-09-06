//
//  UserModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

enum jsonError: Error {
    case decodingError(Error)
}

struct UserWrapper: Codable {
    let results: [User]
    
    static func getUsers(from data: Data) throws -> [User] {
        do {
            let newUser = try JSONDecoder().decode(UserWrapper.self, from: data)
            return newUser.results
        } catch {
            throw jsonError.decodingError(error)
        }
    }
}

struct User: Codable {
    let name: Name
    let email: String
    let phone: String
    let dob: String
    let location: Location
    let picture: Picture
    
    func getFullName() -> String {
        let capTitle = name.title.capitalized
        let capFirst = name.first.capitalized
        let capLast = name.last.capitalized
        
        return "\(capTitle). \(capFirst) \(capLast)"
    }
    
    func getFullAddress() -> String {
        let street = self.location.street.capitalized
        let city = self.location.city.capitalized
        let state = self.location.state.capitalized
        let postcode = self.location.postcode!.uppercased()
        return """
        \(street)
        \(city), \(state) \(postcode)
        """
    }
    
    func getDOB() -> String{
        return dob.toDateFormatInString(dateFormat:"yyyy-MM-dd HH:mm:ss")
    }
    
    
    static func getSortedArray(arr: [User]) -> [User] {
        let newarr = arr.sorted{$0.getFullName() < $1.getFullName()}
        return newarr
    }
    
    static func getFilteredResults(arr:[User], searchText: String) -> [User] {
        var currentFilter: [User]
        currentFilter = arr.filter{$0.getFullName().lowercased().contains(searchText.lowercased())}
        return currentFilter
    }
    
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}


struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String?
    
    private enum CodingKeys: String, CodingKey {
        case street = "street", city = "city", state = "state", postcode = "postcode"
    }
    
    init(street: String, city: String, state: String, postcode: String? ) {
        self.street = street
        self.city = city
        self.state = state
        self.postcode = postcode
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(String.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        
        if let value = try? container.decode(Int.self, forKey: .postcode) {
            postcode = String(value)
        } else {
            postcode = try container.decode(String.self, forKey: .postcode)
        }
    }
    
}

struct Picture: Codable {
    let picture: String
    
    private enum CodingKeys: String, CodingKey {
        case picture = "large"
    }
    
}
