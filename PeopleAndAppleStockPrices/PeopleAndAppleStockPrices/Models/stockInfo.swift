//
//  stockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockInfo: Codable {
    let date: String
    let stockPrice: Double
    let open: Double
    let close: Double
    var day: String {
        return date.components(separatedBy: "-")[2]
    }
    var month: String {
        let dateNumber = date.components(separatedBy: "-")[1]
        return DateFormatter().monthSymbols[(Int(dateNumber) ?? 0) - 1]
    }
    var year: String {
        return date.components(separatedBy: "-")[0]
    }

    
    private enum CodingKeys: String, CodingKey {
        case date
        case stockPrice = "high"
        case open
        case close
    }
    
    static func getStocks() -> [StockInfo] {
        guard let filePath = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError("ERROR: could not find path to JSON file, check for correct naming")
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: url)
            let stock = try JSONDecoder().decode([StockInfo].self, from: data)
            return stock
        } catch {
            fatalError("There was an error decoding your stocks JSON file")
        }
    }
    
    static func stocksSorted() -> [StocksMonthAndYear] {
        let stocks = getStocks().sorted()
        var sortedStocks = [StocksMonthAndYear]()
        let years = Set(stocks.map{$0.year})
        let months = Set(stocks.map{$0.month})
        
        for year in years {
            for month in months {
                let filteredStocks = stocks.filter{$0.year == year && $0.month == month}
                if filteredStocks.count > 0 {
                    let newStocksByMonthAndYear = StocksMonthAndYear(month: month, year: year, stocks: filteredStocks)
                    sortedStocks.append(newStocksByMonthAndYear)
                }
            }
        }
        return sortedStocks
    }
    
}

struct StocksMonthAndYear {
    let month: String
    let year: String
    let stocks: [StockInfo]
    
    
    func getMonthAverage() -> Double {
        return stocks.reduce(0, { (intermediateResult, stock) -> Double in
            intermediateResult + stock.open
        }) / Double(stocks.count)
    }
}

extension StockInfo: Comparable {
    //TODO: Clean this comparison up
    static func < (lhs: StockInfo, rhs: StockInfo) -> Bool {
        
        if let rhsDay = Int(rhs.day) {
            if let lhsDay = Int(lhs.day) {
                if let rhsMonth = Int(rhs.month) {
                    if let lhsMonth = Int(lhs.month) {
                        if let lhsYear = Int(lhs.year) {
                            if let rhsYear = Int(rhs.year) {
                                
                                
                                if lhsYear < rhsYear {
                                    return true
                                } else if lhsYear > rhsYear {
                                    return false
                                } else {
                                    if lhsMonth < rhsMonth {
                                        return true
                                    } else if lhsMonth > rhsMonth {
                                        return false
                                    } else {
                                        if lhsDay < rhsDay {
                                            return true
                                        } else if lhsDay > rhsDay {
                                            return false
                                        } else {
                                            return true
                                        }
                                    }
                                }
                                
                                
                            }
                        }
                    }
                }
            }
        }
        return false
    }
}
