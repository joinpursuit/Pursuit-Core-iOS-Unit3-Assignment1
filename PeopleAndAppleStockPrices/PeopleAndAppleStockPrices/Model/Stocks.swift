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

struct calculate {
    static func monthlyAverage(from arr: [Stocks]) -> Double {
        var returnDouble: Double = 0
        for element in arr {
            returnDouble += element.open
        }
        return returnDouble/Double(arr.count)
    }
}
