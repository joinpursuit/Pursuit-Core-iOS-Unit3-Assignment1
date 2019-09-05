//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct Stock: Codable {
    var date: String
    var open: Double
    var close: Double
    var label: String
    var high: Double
    var low: Double
    
    var sectionName: String {
        let components = date.components(separatedBy: "-")
        let year = components[0]
        let month = components[1]
        return "\(monthDictionary[month]!) \(year)"
    }
    
    private let monthDictionary = ["01":"January", "02": "February", "03": "March",
                            "04": "April","05": "May", "06": "June", "07": "July", "08": "August","09":"September", "10": "October", "11": "November", "12": "December"]
    
    static func getStocks(from data: Data) -> [Stock] {
        do {
            let stockInfo = try JSONDecoder().decode([Stock].self, from: data)
            return stockInfo
        } catch let decodeError {
            fatalError("could not decode info \(decodeError)")
        }
}

    
}
    











