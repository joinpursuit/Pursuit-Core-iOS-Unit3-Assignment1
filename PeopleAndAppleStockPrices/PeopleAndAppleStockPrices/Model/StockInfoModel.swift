//
//  StockInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockInformation: Codable {
    var date: String
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Int
    var unadjustedVolume: Int
    var change: Double
    var changePercent: Double
    var vwap: Double
    var label: String?
    var changeOverTime: Double
    var year: Int {
        let components = date.components(separatedBy: "-")
        return Int(components[0])!
    }
    
    var month: Int {
        let components = date.components(separatedBy: "-")
     return Int(components[1])!
    }
    
}


struct StockSection: Codable {
    var year: Int
    var month: Int
    var stocks: [StockInformation]
    var label: String
    var average: Double {
        var sum = Double()
        var averageCounter = Double()
        for price in stocks{
            sum += price.open
            averageCounter += 1
        }
        return (sum/averageCounter)
    }
    
    static func createSections(from stocks: [StockInformation]) -> [StockSection] {
        var results: [StockSection] = []
        //Add all dates to set
        var dates: Set<String> = Set()
        for stock in stocks.sorted(by: {$0.year < $1.year}){
            let components = stock.date.components(separatedBy: "-")
            let year = Int(components[0])!
            let month = Int(components[1])!
            dates.insert("\(year)-\(month)")
        }
        
        //Loop through set, create sections
        
        for date in dates.sorted() {
            let components = date.components(separatedBy: "-")
            let year = Int(components[0])!
            let month = Int(components[1])!
            
            let stocks = stocks.filter{$0.year == year && $0.month == month}
            
            guard let firstElment = stocks.first else { continue }
            
            //Get string dates
            
           
            
            let section = StockSection(year: year, month: month, stocks: stocks, label: firstElment.label ?? "")
            
            results.append(section)
        }
        
        return results
    }
    
}
