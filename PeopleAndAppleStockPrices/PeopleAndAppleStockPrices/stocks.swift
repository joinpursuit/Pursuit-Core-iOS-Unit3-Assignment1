//
//  stocks.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jack Wong on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct Stocks: Codable{
    let date: String
    let open: Double
    let close: Double
    
    //dictionary used to display the names of the Months
    let MonthFormatDictionary = [
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
    
    //computed property used in order to separate by month/date
    var sectionName: String {
        var dateFormatted = date.components(separatedBy: "-")
        let year = dateFormatted[0], month = dateFormatted[1]
        return "\(MonthFormatDictionary[month]!) - \(year)"
    }
}

