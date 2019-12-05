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
    var dob: String
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
    // MARK: Type Methods of UserInfo
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
    
    static func getAllUsers() -> [User]{
        guard let fileURL = Bundle.main.url(forResource: "userinfo" , withExtension: "json") else {
            fatalError("Could not access valid url")
        }
        
        var data  = Data()
        var users = [User]()
        
        do {
            data = try Data.init(contentsOf: fileURL)
            users = try JSONDecoder().decode(UserInfo.self, from: data).results
        } catch {
            print("Encountered Error: \(error)")
        }
        return users
    }
    
    static func displayDate(date: String) -> String{
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withDashSeparatorInDate,
                                          .withFullDate]
        isoDateFormatter.timeZone = TimeZone.current
        let dateFormatter = DateFormatter()
        guard let dateOfBirth = isoDateFormatter.date(from: date) else{
            return ""
        }
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let dateFormattedString = dateFormatter.string(from: dateOfBirth)
        return dateFormattedString
    }
    
}

