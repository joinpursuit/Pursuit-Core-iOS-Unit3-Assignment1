//
//  APPLStockPricesModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Bienbenido Angeles on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockInfo:Decodable {
    let date: String
    let open: Double
    let close: Double
    let changePercent: Double
    let label: String
}

extension StockInfo{
    static func getStockInfo(filename: String, ext: String) -> [StockInfo]{
        let data = Bundle.readRawjSONData(filename: filename, ext: ext)
        var stocks = [StockInfo]()
        do{
            let userData = try JSONDecoder().decode([StockInfo].self, from: data)
            stocks = userData
        } catch{
            fatalError("decoding error \(error)")
        }
        return stocks
    }
    
    static func getStockDataAsMatrix() -> [[StockInfo]] {
        let filename = "applstockinfo"
        let ext = "json"
        let stockData = StockInfo.getStockInfo(filename: filename, ext: ext)
        
        let stockDataDateToString = stockData.map{$0.date.convertDateStringtoString()}
        
        let uniqueSections = Set(stockDataDateToString)
        
        var stockMatrix = Array(repeating: [StockInfo](), count: uniqueSections.count)

        var currentIndex = 0
        var currentSection = stockDataDateToString.first
        for section in stockData{
            let stockDate = section.date.convertDateStringtoString()
         
            if stockDate == currentSection{
                stockMatrix[currentIndex].append(section)
            } else {
                currentIndex += 1
                currentSection = stockDate
                stockMatrix[currentIndex].append(section)
            }
        }
        //dump(stockMatrix)
        return stockMatrix
    }
    
    static func averageForMonth(section: [StockInfo]) -> Double{
        let sum = section.reduce(0.0){$0 + $1.open}
        let average = sum / Double(section.count)
        return average
    }
    
    func isStockGreen() -> Bool{
        if self.changePercent > 0{
            return false
        } else {
            return true
        }
    }
}
