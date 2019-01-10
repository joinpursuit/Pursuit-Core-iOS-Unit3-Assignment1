//
//  StockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
struct StockData : Codable {
    //let label : String
    let open : Double
    let close : Double
    let date: String
    //let high : String
    //let low : String
    
    //section - date + average fro monthn
    let months: [String : String] = ["01": "January", "02": "February","03": "March" , "04" : "April", "05": "May", "06": "June", "07":"July", "08": "August", "09":"September", "10" : "October", "11" : "November", "12":"December"]
    
    var sectionName : String {
        let dateComponets = date.components(separatedBy: "-")
        let month = dateComponets[1]
        let year = dateComponets[0]
        return "\(months[month]!) \(year)"
    }
    
}
