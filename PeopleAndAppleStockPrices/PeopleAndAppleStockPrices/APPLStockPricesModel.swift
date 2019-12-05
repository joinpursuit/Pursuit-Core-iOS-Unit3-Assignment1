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
    
    static func convertDateFromDataToDate(dateString: String) -> Date{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM - YYYY"
        guard let validDate = dateFormat.date(from: dateString) else {
            return Date()
        }
        return validDate
    }
    
    static func convertDateToString(dateObj: Date) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM - YYYY"
        let validDateAsString = dateFormat.string(from: dateObj)
        return validDateAsString
    }
    
    static func convertDateFromDataToString(dateString: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM - YYYY"
        guard let validDate = dateFormat.date(from: dateString) else {
            return String()
        }
        
        let validDateAsString = dateFormat.string(from: validDate)
        return validDateAsString
    }
    
    func getStockDataAsMatrix() -> [[StockInfo]] {
        let filename = "applstockinfo"
        let ext = "json"
        let stockData = StockInfo.getStockInfo(filename: filename, ext: ext)
        let stockDataDateToDate = stockData.map{StockInfo.convertDateFromDataToDate(dateString: $0.date)}
        let sectionsNameSortedAsString = stockDataDateToDate.sorted{$0 < $1}.map{StockInfo.convertDateToString(dateObj: $0)}
        let uniqueSections = Set(sectionsNameSortedAsString)
        var stockMatrix = Array(repeating: [StockInfo](), count: uniqueSections.count)
        
        var currentIndex = 0
        var currentSection = sectionsNameSortedAsString.first
        for section in stockData{
            if StockInfo.convertDateFromDataToString(dateString: section.date) == currentSection{
                stockMatrix[currentIndex].append(section)
            } else {
                currentIndex += 1
                currentSection = StockInfo.convertDateFromDataToString(dateString: section.date)
                stockMatrix[currentIndex].append(section)
            }
        }
        return stockMatrix
    }
}
