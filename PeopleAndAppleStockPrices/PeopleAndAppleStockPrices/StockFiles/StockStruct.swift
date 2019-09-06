//
//  StockStruct.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit


struct AppleStockPrices: Codable {
    let label: String
    let date: String
    let open: Double
    let close: Double
   
    var sectionName: String {
        let components = date.components(separatedBy: "-")
        let year = components[0]
        let month = components[1]
        return "\(monthDictionary[month]!) \(year)"
        
    }

    private let monthDictionary = ["01":"January", "02": "February", "03": "March",
                                   "04": "April","05": "May", "06": "June", "07": "July", "08": "August","09":"September", "10": "October", "11": "November", "12": "December"]
    
    static func getStockData(from data: Data) throws -> [AppleStockPrices] {
        do {
            let stockData = try JSONDecoder().decode([AppleStockPrices].self, from: data)
            return stockData
        } catch {
            print(error)
            throw error
        }
    }

}
