//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liubov Kaper  on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct Stock: Decodable {
    let date: String
    let open: Double
    let label: String
    let change: Double
    let close: Double
    
}

extension Stock {
    static func getStock(from: Data) -> [Stock] {
        var stockInfos = [Stock]()
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else {
            fatalError("could not locate json url")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let stockData = try JSONDecoder().decode([Stock].self, from: data)
            stockInfos = stockData
        } catch {
            fatalError("faild to load contents \(error)")
        }
        
        return stockInfos
    }
    
    static func stockSections() -> [[Stock]] {
        let filename = "applstockinfo"
        let ext  = "json"
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        let stocks = getStock(from: data )
        let uniqueSections = Set(stocks.map {$0.date})
        
        var noDayArr = [String]()
        for date in uniqueSections {
            
            var theDate = date.components(separatedBy: "-")
            theDate.removeLast()
            let newDate = theDate.joined(separator: " ")
            noDayArr.append(newDate)
        }
    
        var sections = Array(repeating: [Stock](), count: uniqueSections.count)
        noDayArr = noDayArr.sorted()
        
        var currentIndex = 0
        var sectionIndex = 0
        var currentStock = noDayArr[currentIndex]
        
        for stock in stocks {
            var theDate = stock.date.components(separatedBy: "-")
            theDate.removeLast()
            let dateWithNewFormat = theDate.joined(separator: " ")
            
            if dateWithNewFormat == currentStock {
                sections[currentIndex].append(stock)
            } else {
                currentStock = dateWithNewFormat
                currentIndex += 1
                sectionIndex += 1
                sections[currentIndex].append(stock)
            }
        }
        
        // make new empty array
        // loop through stocksections seperare remove last and then join and then add to new array then sort
        
        return sections
    }
}
