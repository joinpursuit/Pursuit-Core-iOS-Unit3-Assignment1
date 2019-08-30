//
//  ModelOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
struct RandomUsers:Codable {
    let results:[Results]
}
struct Results:Codable {
    let name:Name
    let email:String
    let location:Location
    let phone:String
    let dob:DOB
}
struct DOB:Codable {
    let date:String
    
}
struct Name:Codable {
    let title:String
    let first:String
    let last:String
    func getName() -> String {
        return title.capitalizingFirstLetter() + " " + first.capitalizingFirstLetter() + " " + last.capitalizingFirstLetter()
    }
}
struct Location:Codable {
    let street:String
    let city:String
    let state:String
    
    func capitalizeCity() -> String {
       return city.capitalizingFirstLetter()
    }
    func getLocation() -> String {
        return """
        
        Address Information
        
        State: \(state)
        City: \(city)
        Street: \(street)
        
        """
}
}

