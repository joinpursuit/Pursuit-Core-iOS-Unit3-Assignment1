//
//  userInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Cameron Rivera on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserInfo: Decodable{
    let results: [User]
}

struct User: Decodable{
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let dob: String
}

struct Name: Decodable{
    let title: String
    let first: String
    let last: String
}

struct Location: Decodable{
    let street: String
    let city: String
    let state: String
}

extension UserInfo{
    static func getData(from file: String, with ext: String) -> Data {
        guard let fileURL = Bundle.main.url(forResource: file, withExtension: ext) else {
            fatalError("Could not access valid url from file name \(file)\(ext)")
        }
        var data  = Data()
        do {
            data = try Data.init(contentsOf: fileURL)
        } catch {
            print("Encountered Error: \(error)")
        }
        return data
    }
    
    static func getUsers(using data: Data) -> [User] {
        var users = [User]()
        do {
            let usersInfo = try JSONDecoder().decode(UserInfo.self, from: data)
            users = usersInfo.results
        } catch {
            print("Encountered Error: \(error)")
        }
        return users
    }
}
