//
//  Stocks.swift
//  PeopleAndAppleStockPrices
//
//  Created by Leandro Wauters on 12/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let date: String
    let open: Double
//    let high: Double
//    let low: Double
    let close: Double
//    let label: String
    let change: Double
}


struct Reduce {
    static func reduce (stocks: [Stocks]) -> String {
        return String(format: "%.02f", stocks.reduce(0){$0 + $1.open / Double(stocks.count)})
        
    }
}

struct dates {
    static func getDates(stock: Stocks) -> String {
        var month = String()
        var year = String()
        let arr = stock.date.components(separatedBy: "-")
        month = arr[0]
        year = arr[1]
        return "\(year)-\(month)"
    }
}
