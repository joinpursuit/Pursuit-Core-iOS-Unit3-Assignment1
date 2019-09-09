//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Rifkin on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    private let date: String
    let opening: Double
    let closing: Double
    var day: String {
        return date.components(separatedBy: "-")[2]
    }
    var month: String {
        return date.components(separatedBy: "-")[1]
    }
    var year: String {
        return date.components(separatedBy: "-")[0]
    }
    
    private enum CodingKeys: String, CodingKey {
        case date
        case opening = "open"
        case closing = "close"
    }

    private static func getStocks() -> [Stock] {
        guard let fileName = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let stocks = try JSONDecoder().decode([Stock].self, from: data)
            return stocks
        } catch {
            fatalError()
        }
    }
    
    static func getStocksSortedByMonthAndYear() -> [StocksByMonthAndYear] {
        let stocks = getStocks().sorted()
        var sortedStocks = [StocksByMonthAndYear]()
        let years = Set(stocks.map{$0.year})
        let months = Set(stocks.map{$0.month})
        
        for year in years {
            for month in months {
                let filteredStocks = stocks.filter{$0.year == year && $0.month == month}
                if filteredStocks.count > 0 {
                    let newStocksByMonthAndYear = StocksByMonthAndYear(month: month, year: year, stocks: filteredStocks)
                    sortedStocks.append(newStocksByMonthAndYear)
                }
            }
        }
        return sortedStocks
    }
}

extension Stock: Comparable {
    //TODO: Clean this comparison up
    static func < (lhs: Stock, rhs: Stock) -> Bool {
        if Int(lhs.year)! < Int(rhs.year)! {
            return true
        } else if Int(lhs.year)! > Int(rhs.year)! {
            return false
        } else {
            if Int(lhs.month)! < Int(rhs.month)! {
                return true
            } else if Int(lhs.month)! > Int(rhs.month)! {
                return false
            } else {
                if Int(lhs.day)! < Int(rhs.day)! {
                    return true
                } else if Int(lhs.day)! > Int(rhs.day)! {
                    return false
                } else {
                    return true
                }
            }
        }
    }
}


struct StocksByMonthAndYear {
    let month: String
    let year: String
    let stocks: [Stock]
    init(month: String, year: String, stocks: [Stock]) {
        self.month = month
        self.year = year
        self.stocks = stocks.sorted()
    }
    
    func getMonthAverage() -> Double {
        return stocks.reduce(0, { (intermediateResult, stock) -> Double in
            intermediateResult + stock.opening
        }) / Double(stocks.count)
    }
}
