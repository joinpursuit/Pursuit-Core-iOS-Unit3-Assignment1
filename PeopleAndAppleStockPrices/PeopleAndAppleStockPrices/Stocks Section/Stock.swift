//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct AppleStockInfo: Codable {
    let appleStocksInfo: [AppleStocks]
}

struct AppleStocks: Codable {
    let date: String
    let open: Double
    let close: Double
    let change: Double
    
    var year: Int {
        let components = date.components(separatedBy: "-")
        return Int(components[0])!
    }
    
    var month: Int {
        let components = date.components(separatedBy: "-")
        return Int(components[1])!
    }
    
    var sectionName: String {
        let components = date.components(separatedBy: "-")
        let year = components[0]
        let month = components[1]
        return "\(MonthsDict[month]!) - \(year)"
    }
    private let MonthsDict = [
        "01":"January",
        "02":"February",
        "03":"March",
        "04":"April",
        "05":"May",
        "06":"June",
        "07":"July",
        "08":"August",
        "09":"September",
        "10":"October",
        "11":"November",
        "12":"December"
    ]

}



