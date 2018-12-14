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
    var formattedDate: String {
        var Ddate = date
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "MMMM-yyyy"
            Ddate = dateFormatter.string(from: date)
          
        }
      return Ddate
    }
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
    
    
    var stockSectionName:String {
        return formattedDate
    }
    
}


struct StockSection: Codable {
    var year: Int
    var month: Int
    var stocks: [StockInformation]
    var label: String
    
    
    
    var average: String {
        var sum = Double()
        var averageCounter = Double()
        for price in stocks{
            sum += price.open
            averageCounter += 1
        }
        return String(format: "%0.2f", sum/averageCounter)
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
            
           
            
            let section = StockSection(year: year, month: month, stocks: stocks, label: firstElment.formattedDate)

            
            results.append(section)
        }
        
        return results
    }
    
}
