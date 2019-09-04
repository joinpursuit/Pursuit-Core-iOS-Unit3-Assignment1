//
//  JSON.swift
//  PeopleAndAppleStockPrices
//
//  Created by EricM on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct PeopleWrapper: Codable{
    let people: [Person]
    //    let email: String
    //    let frame: [Image]
    //    let home: [Address]
    
    static func getPeople(from data: Data) -> PeopleWrapper{
        do{
            let human = try JSONDecoder().decode(PeopleWrapper.self, from: data)
            return human
        } catch let anError { fatalError( "\(anError)" )}
    }
    
    enum CodingKeys: String, CodingKey {
        case people = "results"
    }
}
struct Person: Codable {
    let name: Name
    let email: String
    let picture: Picture
    let location: Location
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    struct Picture: Codable{
        let large: String
        let medium: String
    }
    struct Location: Codable{
        let city: String
    }
}


//-----------------------------------------------------------------------------
struct Stock: Codable {
    let date: String
    let close: Double
    let open: Double
    let high: Double
    let low: Double
    let volume: Int
    let label: String
    
    
    static func getStock(from data: Data) -> [Stock]{
        do{
            let money = try JSONDecoder().decode([Stock].self, from: data)
            return money
        } catch let anError { fatalError( "\(anError)" )}
    }
}


