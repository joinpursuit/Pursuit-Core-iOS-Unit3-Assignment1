//
//  Stocks.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jane Zhu on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
}

struct StockerHelperPropertiesMethods {
    static var monthDictionary: [String: String] = ["01":"January", "02":"February", "03":"March", "04":"April", "05":"May", "06":"June", "07":"July", "08":"August", "09":"September", "10":"October", "11":"November", "12":"December"]
    
    static func formatMonthCorrectly(_ month: Int) -> String {
        if month < 10 {
            return "0\(month.description)"
        } else {
            return month.description
        }
    }
    
    static func calculateMonthlyAverage(from arr: [Stocks]) -> Double {
        var returnDouble: Double = 0
        for element in arr {
            returnDouble += element.open
        }
        return returnDouble/Double(arr.count)
    }
    
    static func monthLookingFor(is arr: [String], from month: String) -> Bool {
        if arr[1] == month {
            return true
        } else {
            return false
        }
    }
    
    static func yearLookingFor(is arr: [String], from year: String) -> Bool {
        if arr[0] == year {
            return true
        } else {
            return false
        }
    }
}
