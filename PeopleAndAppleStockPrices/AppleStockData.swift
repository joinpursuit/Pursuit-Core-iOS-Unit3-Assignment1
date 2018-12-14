//
//  AppleStockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ramu on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct AppleStockData: Codable {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
    var sectionName: String {
        let components = date.components(separatedBy: "-")
        let year = components[0]
        let month = components[1]
        return "\(monthDic[month]!) \(year)"
    }
    private let monthDic = ["01":"January", "02": "February", "03": "March",
                           "04": "April","05": "May", "06": "June", "07": "July", "08": "August","09":"September", "10": "October", "11": "November", "12": "December"]
    
}

