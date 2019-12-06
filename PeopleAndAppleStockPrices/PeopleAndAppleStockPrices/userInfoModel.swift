//
//  userInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Bienbenido Angeles on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let results: [User]
}

struct User: Decodable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.name.returnFullName() < rhs.name.returnFullName()
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name.returnFullName() == rhs.name.returnFullName()
    }
    
    let name: Name
    let location: Location
    let email: String
    let cell: String
    let picture: Picture
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Location: Decodable {
    let city: String
    let state: String
}

struct Picture: Decodable{
    let large: String
    let medium: String
    let thumbnail: String
}

extension User{
    static func getUsers(from data: Data) -> [User] {
        var users = [User]()
        
        do{
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            users = userData.results
        }catch{
            fatalError("decoding error \(error)")
        }
        
        return users
    }
    
//    static func getUsersSorted() -> [User]{
//        let fileName = "userinfo"
//        let ext = "json"
//        let data = Bundle.readRawjSONData(filename: fileName, ext: ext)
//        let users = User.getUsers(from: data).sorted{$0.name.first < $1.name.first}
//        return users
//    }
}

extension Name {
    
    func returnFullName() -> String{
        var firstName = self.first
        var lastName = self.last
        
        firstName.capitalizeFirstLetter()
        lastName.capitalizeFirstLetter()
        
        let fullName = "\(firstName) \(lastName)"
        return fullName
    }
}
