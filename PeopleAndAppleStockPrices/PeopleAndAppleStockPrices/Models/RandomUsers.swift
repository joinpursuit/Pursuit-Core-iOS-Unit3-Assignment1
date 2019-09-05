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
    let picture:Picture
}
struct Picture:Codable {
    let large: URL
    let medium: URL
}
struct DOB:Codable {
    let date:String
    
}
struct Name:Codable {
    let title:String
    let first:String
    let last:String
    func getName() -> String {
        return title.capitalizingFirstLetter() + "." + " " + first.capitalizingFirstLetter() + " " + last.capitalizingFirstLetter()
    }
}
struct Location:Codable {
    let street:String
    let city:String
    let state:String
    
    func capitalizeCity() -> String {
      var emptyStr = ""
        if city.contains(" ") || city.contains("-") {
        if city.contains(" ") {
            let array1 =  city.components(separatedBy: " ")
            for city1 in array1 {
                emptyStr += city1.capitalizingFirstLetter() + " "
            }
        } else {
            let array1 = city.components(separatedBy: "-")
            for city1 in array1 {
                emptyStr += city1.capitalizingFirstLetter() + " "
                
            }
        }
        return emptyStr
        } else {
        return city.capitalizingFirstLetter()
        }
    }
        func capitalizeState() -> String {
            var emptyStr = ""
            if state.contains(" ") || city.contains("-") {
                if state.contains(" ") {
                    let array1 =  state.components(separatedBy: " ")
                    for state1 in array1 {
                        emptyStr += state1.capitalizingFirstLetter() + " "
                    }
                } else {
                    let array1 = state.components(separatedBy: "-")
                    for state1 in array1 {
                        emptyStr += state1.capitalizingFirstLetter() + " "
                        
                    }
                }
                return emptyStr
            } else {
                return state.capitalizingFirstLetter()
            }
    }
            func capitalizeStreet() -> String {
                var emptyStr = ""
                        let array1 =  street.components(separatedBy: " ")
                        for street1 in array1 {
                            emptyStr += street1.capitalizingFirstLetter() + " "
                }
                    return emptyStr
                
    }
    func getLocation() -> String {
        return """
        
        Address Information
        
        State: \(capitalizeState())
        City: \(capitalizeCity())
        Street: \(capitalizeStreet())
        
        """
}
    
}

