//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Nathalie  on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

class Stock: Codable {
    let date: String
    let open: Double
    let close: Double
    var sectionName: String {
        var dateComponents = date.components(separatedBy: "-")
        let year = dateComponents[0]
        let month = dateComponents[1]
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
