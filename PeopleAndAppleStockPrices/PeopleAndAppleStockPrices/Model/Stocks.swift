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

struct StocksHelperPropertiesAndMethods {
    static var monthDictionary: [String: String] = ["01":"January", "02":"February", "03":"March", "04":"April", "05":"May", "06":"June", "07":"July", "08":"August", "09":"September", "10":"October", "11":"November", "12":"December"]
    
    static func formatMonthCorrectly(_ month: Int) -> String {
        switch month {
        case 1:
            return "01"
        case 2:
            return "02"
        case 3:
            return "03"
        case 4:
            return "04"
        case 5:
            return "05"
        case 6:
            return "06"
        case 7:
            return "07"
        case 8:
            return "08"
        case 9:
            return "09"
        case 10:
            return "10"
        case 11:
            return "11"
        case 12:
            return "12"
        default:
            return "invalid month"
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
