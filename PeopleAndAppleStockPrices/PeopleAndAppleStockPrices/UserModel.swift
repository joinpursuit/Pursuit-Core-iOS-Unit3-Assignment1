//
//  UserModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit


struct UserInfo: Codable {
    var results: [User]

    static func getInfo(from data: Data) -> UserInfo {
        do {
            let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
            return userInfo
        } catch let decodeError {
            fatalError("could not decode info \(decodeError)")
            
        }
    }
    
    func sortMe(users: [User]) -> [User] {
        let sorted: [User] = users.sorted { $0.name.first < $1.name.first }
    return sorted
        }
    }


struct User: Codable {
    var name: Name
    var location: Location
    var email: String
    var picture: Picture
    
}


struct Name: Codable {
    var title: String
    var first: String
    var last: String

    func fullName() -> String {
        return "\(title.capitalizingFirstLetter()) \(first.capitalizingFirstLetter()) \(last.capitalizingFirstLetter())"
    }
}

struct Location: Codable {
    var street: String
    var city: String
    var state: String
    var postcode: String
    
    func fullAddress() -> String{
        return "\(street.capitalizingFirstLetter()), \(city.capitalizingFirstLetter()), \(state.capitalizingFirstLetter()) , \(postcode)"
    }
}

struct Picture: Codable {
    var medium: String
    var large: String
    var thumbnail: String
    
    func loadImage(imageView: UIImageView){
        let urlStr = large
        guard let url = URL(string: urlStr) else {fatalError()}
        DispatchQueue.global(qos: .userInitiated).async {
        do { let data = try Data(contentsOf: url)
        imageView.image = UIImage(data: data)
        }
        catch {
            fatalError("unable to pull image")
        }
    }
    }
}


